import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:localservice/components/audio_player.dart';
import 'package:localservice/components/video_message_player.dart';
import 'package:path/path.dart' as path;
import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:localservice/components/gray_button.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/size_config.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

class ChatWidget extends StatefulWidget {
  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  List<types.Message> _messages = [];
  late String user_id;
  late types.User _user;
  late AppService _appService;
  bool isTyping = false;

  dynamic RoomID = null;
  bool connectionTimeOut = false;
  bool connectionError = false;
  bool requestingLoadMore = false;
  bool loadingMessage = false;
  WebSocket? channel = null;

  bool isSendingFile = false;
  Timer _timer = Timer(Duration(milliseconds: 1), () {});
  Timer _typingTimer = Timer(Duration(milliseconds: 1), () {});
  Timer _recordingTimer = Timer(Duration(milliseconds: 1), () {});
  final Dio dio = Dio();
  bool loading = false;
  bool downloadingFile = false;
  double _progressValue = 0;

  String sendMessageText = '';
  TextEditingController eCtrl = TextEditingController();
  bool voiceRecorded = false;
  double timeCounter = 0;
  bool startedVoiceRecording = false;
  bool _mRecorderIsInited = false;
  Codec _codec = Codec.aacMP4;
  String _mPath = '';
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool openedRecorder = false;
  static const theSource = AudioSource.microphone;

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    if (_appService.selectedChatRoomData != null) {
      RoomID = {'room_id': _appService.selectedChatRoomData['id']};
      initSocket();
      initUser();
    }
    if (Platform.isAndroid || Platform.isIOS)
      openTheRecorder().then((value) {
        setState(() {
          _mRecorderIsInited = true;
        });
      });

    super.initState();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    _mRecorder!.closeRecorder();

    setState(() {
      openedRecorder = false;
    });
    await _mRecorder!.openRecorder().then((value) => {openedRecorder = true});
    setState(() {});
    if (openedRecorder == false) return;
    if (kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = '${generateRandomFilename()}.webm';
    }
    if (await _mRecorder!.isEncoderSupported(_codec) && !kIsWeb) {
      var dir = await getExternalStorageDirectory();
      _mPath = '${dir?.path}/${generateRandomFilename()}.mp4';
      _mRecorderIsInited = true;
      return;
    }

    _mRecorderIsInited = true;
  }

  void sendVoiceMessage() async {
    if (!_mRecorderIsInited) {
      return;
    }
    await _mRecorder!.stopRecorder().then((value) async {
      setState(() {
        startedVoiceRecording = false;
        isSendingFile = true;
      });
      _recordingTimer.cancel();
      final file = File(value!);
      dynamic response = await _appService.sendFileToUserInChat(
          file: File(file.path), file_type: 'audio/');
      if (response is String || response == null) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: response,
          ),
        );
        setState(() {
          isSendingFile = false;
        });
      } else {
        setState(() {
          isSendingFile = false;
        });
        dynamic audios = [];
        var request = await HttpClient().headUrl(Uri.parse(
            'https://chat.localservices.app' + response.data['file_url']));
        var response1 = await request.close();
        var sizeInBytes = response1.contentLength;
        var newAudioMessage = {
          'url': 'https://chat.localservices.app' + response.data['file_url'],
          'size': sizeInBytes
        };
        audios.add(newAudioMessage);
        final data = {'type': 'new_audio', 'message': '', 'audios': audios};
        final jsonMessage = json.encode(data);
        channel!.add(jsonMessage);
      }
    });
  }

  Future<bool> saveFile(String url, String fileName) async {
    Directory? directory;
    try {
      if (await _requestPermission(Permission.storage)) {
        if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
          directory = await getDownloadsDirectory();
        } else if (Platform.isIOS || Platform.isAndroid) {
          directory = await getApplicationDocumentsDirectory();
        } else
          return false;
      } else
        return false;

      File saveFile;
      if (Platform.isWindows || Platform.isLinux)
        saveFile = File(directory!.path + '\\' + "$fileName");
      else if (Platform.isIOS || Platform.isMacOS || Platform.isAndroid)
        saveFile = File(directory!.path + '/' + "$fileName");
      else
        return false;
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        try {
          await dio.download(url, saveFile.path,
              onReceiveProgress: (value1, value2) {
            setState(() {
              _progressValue = value1 / value2;
            });
          });
        } on DioError catch (e) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message: e.toString(),
            ),
          );

          return false;
        }
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: saveFile.path,
          ),
        );

        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  String generateRandomFilename() {
    final random = Random();
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final randomString = String.fromCharCodes(Iterable.generate(
      10,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
    return 'file-$randomString';
  }

  void record() {
    if (!_mRecorderIsInited) {
      return;
    }
    if (!openedRecorder) return;
    _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {
        startedVoiceRecording = true;
        startTimer();
      });
    });
  }

  @override
  void dispose() {
    closeConnection();
    eCtrl.dispose();
    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> closeConnection() async {
    if (channel!.closeCode == null) {
      final data = {
        'type': 'disconnect',
      };
      final jsonMessage = json.encode(data);
      channel!.add(jsonMessage);
    }
  }

  Future<void> initUser() async {
    user_id =
        _appService.user != null ? _appService.user['id'].toString() : '0';
    _user = types.User(id: user_id);
  }

  Future<void> initSocket() async {
    const oneSec = Duration(seconds: 60);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (channel == null ||
            channel!.readyState == WebSocket.connecting ||
            channel!.readyState == WebSocket.closing) {
          connectionTimeOut = true;
        } else
          connectionTimeOut = false;
        _timer.cancel();
        setState(() {});
      },
    );
    try {
      Map<String, String> headers = {'apikey': _appService.apiKey};
      setState(() {
        connectionError = false;
      });
      String url =
          "wss://chat.localservices.app/ws/" + RoomID['room_id'].toString();

      channel = await WebSocket.connect(
        Uri.parse(url).toString(),
        headers: headers,
      );

      channel!.listen((message) async {
        var jsonDecodedMessage = jsonDecode(message);
        if (jsonDecodedMessage['type'] == "messages_read") {
          await changeMessageAsSeen(jsonDecodedMessage['messages_ids']);
        }
        if (jsonDecodedMessage['type'] == "image") {
          final file = File(jsonDecodedMessage['images'][0]['url']);
          var response =
              await http.get(Uri.parse(jsonDecodedMessage['images'][0]['url']));
          final bytes = response.bodyBytes;
          final image = await decodeImageFromList(bytes);

          final message = types.ImageMessage(
            author: types.User(
                id: jsonDecodedMessage['data']['user_id'].toString(),
                firstName: _appService.selectedChatUser['full_name']),
            status: jsonDecodedMessage['data']['is_read']
                ? types.Status.seen
                : types.Status.sent,
            createdAt: DateTime.parse(jsonDecodedMessage['data']['created_on'])
                .millisecondsSinceEpoch,
            height: image.height.toDouble(),
            id: jsonDecodedMessage['data']['id'].toString(),
            name: path.basename(file.path),
            size: bytes.length,
            uri: file.path,
            width: image.width.toDouble(),
          );
          _addMessage(message);
          if (jsonDecodedMessage['data']['user_id'] != _appService.user['id']) {
            List<int> unreadMessageIds = [];
            unreadMessageIds.add(jsonDecodedMessage['data']['id']);
            final data = {
              'type': 'messages_read',
              'messages_ids': unreadMessageIds
            };
            final jsonMessage = json.encode(data);
            channel!.add(jsonMessage);
            changeMessageAsSeen(unreadMessageIds);
          }
        }

        if (jsonDecodedMessage['type'] == "video") {
          final file = File(jsonDecodedMessage['videos'][0]['url']);

          final message = types.VideoMessage(
            author: types.User(
                id: jsonDecodedMessage['data']['user_id'].toString(),
                firstName: _appService.selectedChatUser['full_name']),
            status: jsonDecodedMessage['data']['is_read']
                ? types.Status.seen
                : types.Status.sent,
            createdAt: DateTime.parse(jsonDecodedMessage['data']['created_on'])
                .millisecondsSinceEpoch,
            id: jsonDecodedMessage['data']['id'].toString(),
            name: path.basename(file.path),
            size: jsonDecodedMessage['videos'][0]['size'],
            uri: file.path,
          );
          _addMessage(message);
          if (jsonDecodedMessage['data']['user_id'] != _appService.user['id']) {
            List<int> unreadMessageIds = [];
            unreadMessageIds.add(jsonDecodedMessage['data']['id']);
            final data = {
              'type': 'messages_read',
              'messages_ids': unreadMessageIds
            };
            final jsonMessage = json.encode(data);
            channel!.add(jsonMessage);
            changeMessageAsSeen(unreadMessageIds);
          }
        }

        if (jsonDecodedMessage['type'] == "audio") {
          final file =
              File(jsonDecodedMessage['data']['meta_json']['audios'][0]['url']);

          final message = types.AudioMessage(
            duration: Duration(seconds: 3),
            author: types.User(
                id: jsonDecodedMessage['data']['user_id'].toString(),
                firstName: _appService.selectedChatUser['full_name']),
            status: jsonDecodedMessage['data']['is_read']
                ? types.Status.seen
                : types.Status.sent,
            createdAt: DateTime.parse(jsonDecodedMessage['data']['created_on'])
                .millisecondsSinceEpoch,
            id: jsonDecodedMessage['data']['id'].toString(),
            name: path.basename(file.path),
            size: jsonDecodedMessage['data']['meta_json']['audios'][0]['size'],
            uri: file.path,
          );
          _addMessage(message);
          if (jsonDecodedMessage['data']['user_id'] != _appService.user['id']) {
            List<int> unreadMessageIds = [];
            unreadMessageIds.add(jsonDecodedMessage['data']['id']);
            final data = {
              'type': 'messages_read',
              'messages_ids': unreadMessageIds
            };
            final jsonMessage = json.encode(data);
            channel!.add(jsonMessage);
            changeMessageAsSeen(unreadMessageIds);
          }
        }

        if (jsonDecodedMessage['type'] == "messages") {
          setState(() {
            loadingMessage = true;
          });
          await loadMoreMessages(jsonDecodedMessage['data']['messages']);
          setState(() {
            loadingMessage = false;
          });
        }
        if (jsonDecodedMessage['type'] == "all_messages") {
          setState(() {
            loadingMessage = true;
          });
          await _initMessage(jsonDecodedMessage['data']['messages']);
          setState(() {
            loadingMessage = false;
          });
        }
        if (jsonDecodedMessage['type'] == "messages_read") {
          await changeMessageAsSeen(jsonDecodedMessage['messages_ids']);
        }
        if (jsonDecodedMessage['type'] == "message") {
          final textMessage = types.TextMessage(
            author: types.User(
                id: jsonDecodedMessage['data']['user_id'].toString(),
                firstName: _appService.selectedChatUser['full_name']),
            id: jsonDecodedMessage['data']['id'].toString(),
            text: jsonDecodedMessage['data']['message'],
            status: jsonDecodedMessage['data']['is_read']
                ? types.Status.seen
                : types.Status.sent,
            createdAt: DateTime.parse(jsonDecodedMessage['data']['created_on'])
                .millisecondsSinceEpoch,
          );
          _addMessage(textMessage);
          if (jsonDecodedMessage['data']['user_id'] != _appService.user['id']) {
            List<int> unreadMessageIds = [];
            unreadMessageIds.add(jsonDecodedMessage['data']['id']);
            final data = {
              'type': 'messages_read',
              'messages_ids': unreadMessageIds
            };
            final jsonMessage = json.encode(data);
            channel!.add(jsonMessage);
            changeMessageAsSeen(unreadMessageIds);
          }
        }
        if (jsonDecodedMessage['type'] == "typing") {
          if (jsonDecodedMessage['user_id'] ==
              _appService.selectedChatUser['id'])
            setState(() {
              isTyping = true;
            });
        }

        if (jsonDecodedMessage['type'] == "stop_typing") {
          if (jsonDecodedMessage['user_id'] ==
              _appService.selectedChatUser['id'])
            setState(() {
              isTyping = false;
            });
        }
      });
    } catch (e) {
      setState(() {
        connectionError = true;
      });
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> loadMoreMessages(dynamic messageList) async {
    dynamic unreadMessageIds = [];
    Future.delayed(Duration(seconds: 1));
    if (messageList != null) {
      for (int i = 0; i < messageList.length; i++) {
        if (messageList[i]['message'] != null &&
            messageList[i]['msg_type'] == 'message') {
          final textMessage = types.TextMessage(
            author: types.User(
                id: messageList[i]['user_id'].toString(),
                firstName: _appService.selectedChatUser['full_name']),
            id: messageList[i]['id'].toString(),
            text: messageList[i]['message'],
            createdAt: DateTime.parse(messageList[i]['created_on'])
                .millisecondsSinceEpoch,
            status: messageList[i]['is_read']
                ? types.Status.seen
                : types.Status.sent,
          );
          _messages.add(textMessage);
        }
        if (messageList[i]['message'] != null &&
            messageList[i]['msg_type'] == 'image') {
          dynamic data = jsonDecode(messageList[i]['meta_json']);
          File file = File(data['images'][0]['url']);
          var response = await http.get(Uri.parse(data['images'][0]['url']));
          final bytes = response.bodyBytes;
          final image = await decodeImageFromList(bytes);
          final message = types.ImageMessage(
              author: types.User(
                  id: messageList[i]['user_id'].toString(),
                  firstName: _appService.selectedChatUser['full_name']),
              id: messageList[i]['id'].toString(),
              createdAt: DateTime.parse(messageList[i]['created_on'])
                  .millisecondsSinceEpoch,
              status: messageList[i]['is_read']
                  ? types.Status.seen
                  : types.Status.sent,
              height: image.height.toDouble(),
              name: path.basename(file.path),
              size: bytes.length,
              uri: file.path,
              width: image.width.toDouble());
          _messages.add(message);
        }
        if (messageList[i]['message'] != null &&
            messageList[i]['msg_type'] == 'video') {
          dynamic data = jsonDecode(messageList[i]['meta_json']);
          File file = File(data['videos'][0]['url']);
          final message = types.VideoMessage(
            author: types.User(
                id: messageList[i]['user_id'].toString(),
                firstName: _appService.selectedChatUser['full_name']),
            id: messageList[i]['id'].toString(),
            createdAt: DateTime.parse(messageList[i]['created_on'])
                .millisecondsSinceEpoch,
            status: messageList[i]['is_read']
                ? types.Status.seen
                : types.Status.sent,
            name: path.basename(file.path),
            size: data['videos'][0]['size'],
            uri: file.path,
          );
          _messages.add(message);
        }

        if (messageList[i]['message'] != null &&
            messageList[i]['msg_type'] == 'audio') {
          dynamic data = jsonDecode(messageList[i]['meta_json']);
          File file = File(data['audios'][0]['url']);
          final message = types.AudioMessage(
            duration: Duration(seconds: 3),
            author: types.User(
                id: messageList[i]['user_id'].toString(),
                firstName: _appService.selectedChatUser['full_name']),
            id: messageList[i]['id'].toString(),
            createdAt: DateTime.parse(messageList[i]['created_on'])
                .millisecondsSinceEpoch,
            status: messageList[i]['is_read']
                ? types.Status.seen
                : types.Status.sent,
            name: path.basename(file.path),
            size: data['audios'][0]['size'],
            uri: file.path,
          );
          _messages.add(message);
        }
        if (messageList[i]['is_read'] == false &&
            messageList[i]['user_id'] != _appService.user['id'])
          unreadMessageIds.add(messageList[i]['id']);
      }

      if (unreadMessageIds.length != 0) {
        final data = {
          'type': 'messages_read',
          'messages_ids': unreadMessageIds
        };
        final jsonMessage = json.encode(data);

        channel!.add(jsonMessage);
      }
    }
  }

  Future<void> _initMessage(dynamic messageList) async {
    dynamic unreadMessageIds = [];
    Future.delayed(Duration(seconds: 1));
    _messages = [];
    if (messageList != null) {
      for (int i = messageList.length - 1; i > -1; i--) {
        if (messageList[i]['message'] != null &&
            messageList[i]['msg_type'] == 'message') {
          final textMessage = types.TextMessage(
            author: types.User(
                id: messageList[i]['user_id'].toString(),
                firstName: _appService.selectedChatUser['full_name']),
            id: messageList[i]['id'].toString(),
            text: messageList[i]['message'],
            createdAt: DateTime.parse(messageList[i]['created_on'])
                .millisecondsSinceEpoch,
            status: messageList[i]['is_read']
                ? types.Status.seen
                : types.Status.sent,
          );
          _messages.insert(0, textMessage);
        }
        if (messageList[i]['message'] != null &&
            messageList[i]['msg_type'] == 'image') {
          dynamic data = jsonDecode(messageList[i]['meta_json']);
          File file = File(data['images'][0]['url']);
          var response = await http.get(Uri.parse(data['images'][0]['url']));
          final bytes = response.bodyBytes;
          final image = await decodeImageFromList(bytes);
          final message = types.ImageMessage(
              author: types.User(
                  id: messageList[i]['user_id'].toString(),
                  firstName: _appService.selectedChatUser['full_name']),
              id: messageList[i]['id'].toString(),
              createdAt: DateTime.parse(messageList[i]['created_on'])
                  .millisecondsSinceEpoch,
              status: messageList[i]['is_read']
                  ? types.Status.seen
                  : types.Status.sent,
              height: image.height.toDouble(),
              name: path.basename(file.path),
              size: bytes.length,
              uri: file.path,
              width: image.width.toDouble());
          _messages.insert(0, message);
        }
        if (messageList[i]['message'] != null &&
            messageList[i]['msg_type'] == 'video') {
          dynamic data = jsonDecode(messageList[i]['meta_json']);
          File file = File(data['videos'][0]['url']);
          final message = types.VideoMessage(
            author: types.User(
                id: messageList[i]['user_id'].toString(),
                firstName: _appService.selectedChatUser['full_name']),
            id: messageList[i]['id'].toString(),
            createdAt: DateTime.parse(messageList[i]['created_on'])
                .millisecondsSinceEpoch,
            status: messageList[i]['is_read']
                ? types.Status.seen
                : types.Status.sent,
            name: path.basename(file.path),
            size: data['videos'][0]['size'],
            uri: file.path,
          );
          _messages.insert(0, message);
        }

        if (messageList[i]['message'] != null &&
            messageList[i]['msg_type'] == 'audio') {
          dynamic data = jsonDecode(messageList[i]['meta_json']);
          File file = File(data['audios'][0]['url']);
          final message = types.AudioMessage(
            duration: Duration(seconds: 3),
            author: types.User(
                id: messageList[i]['user_id'].toString(),
                firstName: _appService.selectedChatUser['full_name']),
            id: messageList[i]['id'].toString(),
            createdAt: DateTime.parse(messageList[i]['created_on'])
                .millisecondsSinceEpoch,
            status: messageList[i]['is_read']
                ? types.Status.seen
                : types.Status.sent,
            name: path.basename(file.path),
            size: data['audios'][0]['size'],
            uri: file.path,
          );
          _messages.insert(0, message);
        }
        if (messageList[i]['is_read'] == false &&
            messageList[i]['user_id'] != _appService.user['id'])
          unreadMessageIds.add(messageList[i]['id']);
      }

      if (unreadMessageIds.length != 0) {
        final data = {
          'type': 'messages_read',
          'messages_ids': unreadMessageIds
        };
        final jsonMessage = json.encode(data);

        channel!.add(jsonMessage);
      }
    }
  }

  Future<void> _addMessage(types.Message message) async {
    setState(() {
      _messages.insert(0, message);
    });
  }

  PreferredSize appBar(BuildContext context) {
    late AppService _appService =
        Provider.of<AppService>(context, listen: false);
    return PreferredSize(
      child: Container(
        child: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
              ),
              onPressed: () async {
                closeConnection();
                GoRouter.of(context).pushNamed(APP_PAGE.conversation.toName);
              }),
          elevation: 0.0,
          actions: [],
          title: Row(
            children: [
              InkWell(
                onTap: () async {
                  dynamic response = await _appService.getUserProfile(
                      userID: _appService.selectedChatUser['id']);
                  if (response is String || response == null) {
                    showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(
                          message: response,
                        ));
                  } else {
                    _appService.selectedUserProfileData = response.data['data'];
                    _appService.selecteduserProfilePhoneNumber =
                        _appService.selectedChatUser['phone'] == null
                            ? ""
                            : _appService.selectedChatUser['phone'];
                    GoRouter.of(context).pushNamed(APP_PAGE.userProfile.toName);
                  }
                },
                child: Container(
                    child: _appService.selectedChatUser['avatar'] == null ||
                            _appService.selectedChatUser['avatar'] == ""
                        ? Image.asset(
                            'assets/images/profile_sm.png',
                            width: 48,
                            height: 48,
                          )
                        : ExtendedImage.network(
                            _appService.selectedChatUser['avatar'],
                            fit: BoxFit.cover,
                            height: 32,
                            width: 32,
                            cacheHeight: 32,
                            cacheWidth: 32,
                            compressionRatio: 0.5,
                            cache: true,
                            shape: BoxShape.circle,
                            clearMemoryCacheIfFailed: true,
                            clearMemoryCacheWhenDispose: true,
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.failed:
                                  return Image.asset(
                                    'assets/images/profile_sm.png',
                                    width: 48,
                                    height: 48,
                                  );

                                case LoadState.loading:
                                  return Image.asset(
                                    'assets/images/profile_sm.png',
                                    width: 48,
                                    height: 48,
                                  );
                                case LoadState.completed:
                                  break;
                              }
                              return null;
                            },
                          )),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        _appService.selectedOfferIDfromNotification =
                            _appService.selectedChatRoomData['offer']['id'];
                        GoRouter.of(context)
                            .pushNamed(APP_PAGE.myJobOfferid.toName);
                      },
                      child: Container(
                          width: 200,
                          child: Text(
                            _appService.selectedChatUser['full_name'] == null
                                ? ""
                                : _appService.selectedChatUser['full_name'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(20),
                                fontWeight: FontWeight.w600),
                          ))),
                  SizedBox(
                    height: 30,
                    child: isTyping
                        ? Container(
                            height: 30,
                            child: LoadingIndicator(
                                indicatorType: Indicator.ballPulse,

                                /// Required, The loading type of the widget
                                colors: [
                                  context
                                          .watch<AppService>()
                                          .themeState
                                          .customColors[
                                      AppColors.loadingIndicatorColor]!
                                ],

                                /// Optional, The color collections
                                strokeWidth: 2,

                                /// Optional, The stroke of the line, only applicable to widget which contains line
                                backgroundColor: Colors.transparent,

                                /// Optional, Background of the widget
                                pathBackgroundColor: context
                                        .watch<AppService>()
                                        .themeState
                                        .customColors[
                                    AppColors.loadingIndicatorBackgroundColor]

                                /// Optional, the stroke backgroundColor
                                ),
                          )
                        : Text(
                            (_appService.selectedChatUser['is_online'] !=
                                        null &&
                                    _appService.selectedChatUser['is_online'])
                                ? Languages.of(context)!.online
                                : Languages.of(context)!.offline,
                            style: TextStyle(
                              color:
                                  _appService.selectedChatUser['is_online'] !=
                                              null &&
                                          _appService
                                              .selectedChatUser['is_online'] &&
                                          !isTyping
                                      ? Colors.blueAccent
                                      : Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: appBar(
        context,
      ),
      body: Stack(
        children: [
          connectionError || connectionTimeOut
              ? Center(
                  child: SizedBox(
                      width: 200,
                      child: GrayButton(
                          text: Languages.of(context)!.joinRoom,
                          press: () async {
                            connectionTimeOut = false;
                            setState(() {});
                            await initSocket();
                          })))
              : Stack(children: [
                  Chat(
                    audioMessageBuilder: _audioMessageBuilder,
                    videoMessageBuilder: _videoMessageBuilder,
                    isAttachmentUploading: isSendingFile,
                    emptyState: SizedBox(),
                    onEndReached: _handleEndReached,
                    onMessageTap: (context, p1) {
                      var data = p1.toJson();
                      if (p1.type == types.MessageType.file) {
                        showDownloadDialog(data['uri']);
                      }
                    },
                    customBottomWidget: Container(
                      width: double.infinity,
                      height: '\n'.allMatches(sendMessageText).length == 0
                          ? 50
                          : '\n'.allMatches(sendMessageText).length > 5
                              ? 180
                              : 20 +
                                  ('\n'.allMatches(sendMessageText).length +
                                          1) *
                                      25,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 39, 39, 39),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            isSendingFile
                                ? Container(
                                    width: 50,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator()))
                                : IconButton(
                                    onPressed: () {
                                      _handleAttachmentPressed();
                                    },
                                    iconSize: 30,
                                    color: Color.fromARGB(255, 177, 177, 177),
                                    icon: Icon(Icons.attach_file)),
                            Expanded(
                              child: TextFormField(
                                controller: eCtrl,
                                maxLines: 1000,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) async {
                                  setState(() {
                                    sendMessageText = value;
                                  });
                                },
                                autovalidateMode: AutovalidateMode.always,
                                textInputAction: TextInputAction.none,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText:
                                        Languages.of(context)!.hintTextMessage,
                                    fillColor: Color.fromARGB(255, 39, 39, 39),
                                    filled: true),
                              ),
                            ),
                            if (startedVoiceRecording)
                              Row(children: [
                                Text(
                                  (timeCounter / 100).toStringAsFixed(2),
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        startedVoiceRecording = false;
                                        timeCounter = 0;
                                      });
                                      _recordingTimer.cancel();
                                    },
                                    iconSize: 30,
                                    color: Colors.red,
                                    icon: Icon(Icons.delete))
                              ]),
                            IconButton(
                                onPressed: () {
                                  if (Platform.isAndroid || Platform.isIOS) {
                                    if (startedVoiceRecording == true) {
                                      sendVoiceMessage();
                                    } else if (sendMessageText != '') {
                                      _handleSendPressed(types.PartialText(
                                          text: sendMessageText));
                                    } else {
                                      setState(() {
                                        startedVoiceRecording = true;
                                      });
                                      record();
                                    }
                                  } else {
                                    if (sendMessageText != '') {
                                      _handleSendPressed(types.PartialText(
                                          text: sendMessageText));
                                    }
                                  }
                                },
                                iconSize: 30,
                                color: Color.fromARGB(255, 177, 177, 177),
                                icon: sendMessageText != '' ||
                                        startedVoiceRecording
                                    ? Icon(Icons.send)
                                    : Icon(Icons.mic)),
                          ]),
                    ),
                    inputOptions: InputOptions(
                      onTextChanged: _handleUserTyping,
                    ),
                    messages: _messages,
                    onAttachmentPressed: _handleAttachmentPressed,
                    // onMessageTap: _handleMessageTap,
                    onPreviewDataFetched: _handlePreviewDataFetched,
                    onSendPressed: _handleSendPressed,
                    theme: context.watch<AppService>().themeState.isDarkTheme ==
                            false
                        ? DefaultChatTheme(
                            backgroundColor: Color.fromARGB(255, 240, 240, 240),
                            receivedMessageBodyTextStyle:
                                TextStyle(color: Colors.white),
                            primaryColor: Color.fromRGBO(
                                5, 163, 231, 1), // send message backgrou
                            secondaryColor: Colors.black)
                        : DarkChatTheme(
                            backgroundColor: Color.fromARGB(255, 20, 20, 21),
                            messageBorderRadius: 10,
                            primaryColor: Color.fromRGBO(
                                5, 163, 231, 1), // send message background
                            inputBackgroundColor: Color.fromRGBO(68, 68, 68, 1),
                            secondaryColor: Color.fromRGBO(68, 68, 68, 1)),
                    showUserAvatars: false,
                    // showUserNames: true,
                    user: _user,
                  ),
                  if (channel == null ||
                      channel!.readyState == WebSocket.connecting ||
                      channel!.readyState == WebSocket.closing)
                    Positioned(
                        child: Center(
                            child: Text(
                      Languages.of(context)!.connecting + '...',
                      style: TextStyle(fontSize: 18),
                    ))),
                  if (loadingMessage)
                    Positioned(
                        child: Center(child: CircularProgressIndicator())),
                  if (downloadingFile)
                    Positioned(
                        child: Center(
                            child: CircularProgressIndicator(
                      strokeWidth: 10,
                      backgroundColor: Colors.yellow,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                      value: _progressValue,
                    )))
                ]),
          InkWell(
              onTap: () async {},
              child: Container(
                padding: EdgeInsets.fromLTRB(19, 15, 15, 19),
                margin: EdgeInsets.only(top: 1),
                color: !context.watch<AppService>().themeState.isDarkTheme!
                    ? Colors.white
                    : Color.fromRGBO(40, 42, 45, 1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "#" +
                            (_appService.selectedChatRoomData != null
                                ? _appService.selectedChatRoomData['offer']
                                        ['id']
                                    .toString()
                                : "") +
                            ' - ' +
                            (_appService.selectedChatRoomData != null
                                ? _appService.selectedChatRoomData['offer']
                                    ['title']
                                : ""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: context
                                        .watch<AppService>()
                                        .themeState
                                        .isDarkTheme ==
                                    false
                                ? Color.fromRGBO(41, 45, 50, 1)
                                : Color.fromRGBO(205, 209, 214, 1)),
                      ),
                    ),
                    if (_appService.selectedChatRoomData != null)
                      Text(
                        _appService.selectedChatRoomData['offer']['price']
                                .toString() +
                            " " +
                            (_appService.selectedChatRoomData['offer']
                                        ['currency_type'] ==
                                    null
                                ? ""
                                : _appService.selectedChatRoomData['offer']
                                    ['currency_type']),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(30, 163, 233, 1)),
                      ),
                  ],
                ),
              ))
        ],
      ));

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleUserTyping(String text) {
    if (isTyping == false) {
      final data = {
        'type': 'typing',
      };
      final jsonMessage = json.encode(data);
      channel!.add(jsonMessage);
      if (!_typingTimer.isActive) {
        _typingTimer = Timer.periodic(
          Duration(seconds: 3),
          (Timer timer) {
            final data = {
              'type': 'stop_typing',
            };
            final jsonMessage = json.encode(data);
            channel!.add(jsonMessage);
            setState(() {});
            _typingTimer.cancel();
          },
        );
      }
    }
  }

  Future<void> _handleEndReached() async {
    if (requestingLoadMore == false) {
      setState(() {
        requestingLoadMore = true;
      });
      Timer(Duration(milliseconds: 500), () {
        final data = {'type': 'messages', 'offset': _messages.length};
        final jsonMessage = json.encode(data);
        channel!.add(jsonMessage);
        setState(() {
          requestingLoadMore = false;
        });
      });
    }
  }

  Future<void> changeMessageAsSeen(dynamic message_ids) async {
    for (int i = 0; i < message_ids.length; i++) {
      final index = _messages.indexWhere(
          (element) => element.id.toString() == message_ids[i].toString());
      final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
        status: types.Status.seen,
      );
      setState(() {
        _messages[index] = updatedMessage;
      });
    }
  }

  void _handleSendPressed(types.PartialText message) {
    if (message.text == "") return;
    final data = {
      'type': 'message',
      'message': message.text,
    };
    final jsonMessage = json.encode(data);
    channel!.add(jsonMessage);
    eCtrl.text = "";
    setState(() {
      sendMessageText = '';
    });
  }

  void showDownloadDialog(String uri) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  setState(() {
                    downloadingFile = true;
                  });

                  await saveFile(uri, p.basename(uri));
                  setState(() {
                    downloadingFile = false;
                  });
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Download'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleAudioSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Audio'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleVideoSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Video'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAudioSelection() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.audio, allowMultiple: false);

    if (result != null) {
      setState(() {
        isSendingFile = true;
      });
      final files = result.paths.map((path) => File(path!)).toList();
      await Future.forEach(files, (image) async {
        dynamic data = image;
        dynamic response = await _appService.sendFileToUserInChat(
            file: File(data.path), file_type: 'audio/');
        if (response is String || response == null) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: response,
            ),
          );
          setState(() {
            isSendingFile = false;
          });
        } else {
          setState(() {
            isSendingFile = false;
          });
          dynamic audios = [];
          var request = await HttpClient().headUrl(Uri.parse(
              'https://chat.localservices.app' + response.data['file_url']));
          var response1 = await request.close();
          var sizeInBytes = response1.contentLength;
          var newAudioMessage = {
            'url': 'https://chat.localservices.app' + response.data['file_url'],
            'size': sizeInBytes
          };
          audios.add(newAudioMessage);
          final data = {'type': 'new_audio', 'message': '', 'audios': audios};
          final jsonMessage = json.encode(data);
          channel!.add(jsonMessage);
        }
      });
    }
  }

  void _handleVideoSelection() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: false);

    if (result != null) {
      setState(() {
        isSendingFile = true;
      });
      final files = result.paths.map((path) => File(path!)).toList();
      await Future.forEach(files, (image) async {
        dynamic data = image;
        dynamic response = await _appService.sendFileToUserInChat(
            file: File(data.path), file_type: 'video/');
        if (response is String || response == null) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: response,
            ),
          );
          setState(() {
            isSendingFile = false;
          });
        } else {
          setState(() {
            isSendingFile = false;
          });
          dynamic videos = [];
          var request = await HttpClient().headUrl(Uri.parse(
              'https://chat.localservices.app' + response.data['file_url']));
          var response1 = await request.close();
          var sizeInBytes = response1.contentLength;
          var newVideoMessage = {
            'url': 'https://chat.localservices.app' + response.data['file_url'],
            'size': sizeInBytes
          };
          videos.add(newVideoMessage);
          final data = {'type': 'new_video', 'message': '', 'videos': videos};
          final jsonMessage = json.encode(data);
          channel!.add(jsonMessage);
        }
      });
    }
  }

  void _handleImageSelection() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: false);

    if (result != null) {
      setState(() {
        isSendingFile = true;
      });
      final files = result.paths.map((path) => File(path!)).toList();
      await Future.forEach(files, (image) async {
        dynamic data = image;
        dynamic response = await _appService.sendFileToUserInChat(
            file: File(data.path), file_type: 'image/');
        if (response is String || response == null) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: response,
            ),
          );
          setState(() {
            isSendingFile = false;
          });
        } else {
          setState(() {
            isSendingFile = false;
          });
          dynamic images = [];
          var request = await HttpClient().headUrl(Uri.parse(
              'https://chat.localservices.app' + response.data['file_url']));
          var response1 = await request.close();
          var sizeInBytes = response1.contentLength;
          var newVideoMessage = {
            'url': 'https://chat.localservices.app' + response.data['file_url'],
            'size': sizeInBytes
          };
          images.add(newVideoMessage);
          final data = {'type': 'new_image', 'message': '', 'images': images};
          final jsonMessage = json.encode(data);
          channel!.add(jsonMessage);
        }
      });
    }
  }

  Widget _audioMessageBuilder(types.AudioMessage message,
      {required int messageWidth}) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      width: double.tryParse(messageWidth.toString()),
      child: ControlButtons(
        uri: message.uri,
        onDownload: () async {
          setState(() {
            downloadingFile = true;
          });

          await saveFile(message.uri, message.name);

          setState(() {
            downloadingFile = false;
          });
        },
      ),
    );
  }

  Widget _videoMessageBuilder(types.VideoMessage message,
      {required int messageWidth}) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      width: double.tryParse(messageWidth.toString()),
      child: VideoMessagePlayer(
        uri: message.uri,
        size: message.size,
        name: message.name,
        onDownload: () async {
          setState(() {
            downloadingFile = true;
          });

          await saveFile(message.uri, message.name);

          setState(() {
            downloadingFile = false;
          });
        },
      ),
    );
  }

  void startTimer() {
    setState(() {
      timeCounter = 0;
    });
    const oneSec = Duration(milliseconds: 10);
    _recordingTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        timeCounter++;

        setState(() {});
      },
    );
  }
}
