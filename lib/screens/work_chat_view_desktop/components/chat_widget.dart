import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:localservice/components/gray_button.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/screens/job_details/components/full_photo.dart';
import 'package:localservice/size_config.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/cubit/theme_module/provider/theme_cubit.dart';
import 'package:localservice/cubit/theme_module/states/change_theme_states.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
  bool isSendingFile = false;
  dynamic RoomID = null;
  bool connectionTimeOut = false;
  bool connectionError = false;
  bool requestingLoadMore = false;
  bool loadingMessage = false;
  WebSocket? channel = null;
  Timer _timer = Timer(Duration(milliseconds: 1), () {});
  Timer _typingTimer = Timer(Duration(milliseconds: 1), () {});
  final Dio dio = Dio();
  bool loading = false;
  bool downloadingFile = false;
  double _progressValue = 0;
  String sendMessageText = '';
  TextEditingController eCtrl = TextEditingController();
  double timeCounter = 0;

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    if (_appService.selectedChatRoomData != null) {
      RoomID = {'room_id': _appService.selectedChatRoomData['id']};
      initSocket();
      initUser();
    }

    super.initState();
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

  @override
  void dispose() {
    closeConnection();
    eCtrl.dispose();

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

          final message = types.FileMessage(
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

          final message = types.FileMessage(
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
          final message = types.FileMessage(
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
          final message = types.FileMessage(
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

  PreferredSize appBar(BuildContext context, ChangeThemeState themeState) {
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
                  Container(
                      width: 180,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _appService.selectedChatUser['full_name'] == null
                            ? ""
                            : _appService.selectedChatUser['full_name'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(20),
                            fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: 30,
                    child: isTyping
                        ? Container(
                            height: 30,
                            child: LoadingIndicator(
                                indicatorType: Indicator.ballPulse,

                                /// Required, The loading type of the widget
                                colors: [
                                  themeState.customColors[
                                      AppColors.loadingIndicatorColor]!
                                ],

                                /// Optional, The color collections
                                strokeWidth: 2,

                                /// Optional, The stroke of the line, only applicable to widget which contains line
                                backgroundColor: Colors.transparent,

                                /// Optional, Background of the widget
                                pathBackgroundColor: themeState.customColors[
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
  Widget build(BuildContext context) {
    Widget image_carousel = new Container();
    if (_appService.selectedJobData['files'] != null &&
        _appService.selectedJobData['files'].length != 0)
      image_carousel = new Container(
          height: 345.0,
          child: CarouselSlider(
            // height: 400.0,
            options: CarouselOptions(enableInfiniteScroll: false),
            items: _appService.selectedJobData['files'].map<Widget>((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: GestureDetector(
                          child: Image.network(i['link'], fit: BoxFit.fill),
                          onTap: () {
                            Navigator.push<Widget>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageScreen(i['link'],
                                    _appService.selectedJobData['files']),
                              ),
                            );
                          }));
                },
              );
            }).toList(),
          ));
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
        bloc: changeThemeCubit,
        builder: (context, themeState) {
          Locale myLocale = Localizations.localeOf(context);
          return Scaffold(
              appBar: appBar(context, themeState),
              body: DefaultTabController(
                  length: 2,
                  child: new Scaffold(
                      appBar: new PreferredSize(
                        preferredSize: Size.fromHeight(kToolbarHeight),
                        child: new Container(
                          height: 50.0,
                          child: new TabBar(
                            onTap: (value) {},
                            labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            tabs: [
                              Tab(
                                text: Languages.of(context)!.chat,
                              ),
                              Tab(text: Languages.of(context)!.job_detail),
                            ],
                          ),
                        ),
                      ),
                      body: TabBarView(children: [
                        Stack(
                          children: [
                            connectionError || connectionTimeOut
                                ? Center(
                                    child: SizedBox(
                                        width: 200,
                                        child: GrayButton(
                                            text:
                                                Languages.of(context)!.joinRoom,
                                            press: () async {
                                              connectionTimeOut = false;
                                              setState(() {});
                                              await initSocket();
                                            })))
                                : Stack(children: [
                                    Chat(
                                      onMessageTap: (context, p1) {
                                        var data = p1.toJson();
                                        if (p1.type == types.MessageType.file) {
                                          showDownloadDialog(data['uri']);
                                        }
                                      },
                                      emptyState: SizedBox(),
                                      onEndReached: _handleEndReached,
                                      customBottomWidget: Container(
                                        width: double.infinity,
                                        height: '\n'
                                                    .allMatches(sendMessageText)
                                                    .length ==
                                                0
                                            ? 50
                                            : '\n'
                                                        .allMatches(
                                                            sendMessageText)
                                                        .length >
                                                    5
                                                ? 180
                                                : 20 +
                                                    ('\n'
                                                                .allMatches(
                                                                    sendMessageText)
                                                                .length +
                                                            1) *
                                                        25,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 39, 39, 39),
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20)),
                                        ),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              isSendingFile
                                                  ? Container(
                                                      width: 50,
                                                      height: 50,
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child:
                                                              CircularProgressIndicator()))
                                                  : IconButton(
                                                      onPressed: () {
                                                        _handleAttachmentPressed();
                                                      },
                                                      iconSize: 30,
                                                      color: Color.fromARGB(
                                                          255, 177, 177, 177),
                                                      icon: Icon(
                                                          Icons.attach_file)),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: eCtrl,
                                                  maxLines: 1000,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  onChanged: (value) async {
                                                    setState(() {
                                                      sendMessageText = value;
                                                    });
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode.always,
                                                  textInputAction:
                                                      TextInputAction.none,
                                                  decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      hintText:
                                                          Languages.of(context)!
                                                              .hintTextMessage,
                                                      fillColor: Color.fromARGB(
                                                          255, 39, 39, 39),
                                                      filled: true),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    if (sendMessageText != '') {
                                                      _handleSendPressed(
                                                          types.PartialText(
                                                              text:
                                                                  sendMessageText));
                                                    }
                                                  },
                                                  iconSize: 30,
                                                  color: Color.fromARGB(
                                                      255, 177, 177, 177),
                                                  icon: Icon(Icons.send)),
                                            ]),
                                      ),
                                      inputOptions: InputOptions(
                                        onTextChanged: _handleUserTyping,
                                      ),
                                      messages: _messages,
                                      isAttachmentUploading: isSendingFile,
                                      onAttachmentPressed:
                                          _handleAttachmentPressed,
                                      // onMessageTap: _handleMessageTap,
                                      onPreviewDataFetched:
                                          _handlePreviewDataFetched,
                                      onSendPressed: _handleSendPressed,
                                      theme: themeState.isDarkTheme == false
                                          ? DefaultChatTheme(
                                              backgroundColor: Color.fromARGB(
                                                  255, 240, 240, 240),
                                              receivedMessageBodyTextStyle:
                                                  TextStyle(
                                                      color: Colors.white),
                                              primaryColor: Color.fromRGBO(
                                                  5,
                                                  163,
                                                  231,
                                                  1), // send message backgrou
                                              secondaryColor: Colors.black)
                                          : DarkChatTheme(
                                              backgroundColor: Color.fromARGB(
                                                  255, 20, 20, 21),
                                              messageBorderRadius: 10,
                                              primaryColor: Color.fromRGBO(
                                                  5,
                                                  163,
                                                  231,
                                                  1), // send message background
                                              inputBackgroundColor:
                                                  Color.fromRGBO(68, 68, 68, 1),
                                              secondaryColor: Color.fromRGBO(
                                                  68, 68, 68, 1)),
                                      showUserAvatars: false,
                                      // showUserNames: true,
                                      user: _user,
                                    ),
                                    if (channel == null ||
                                        channel!.readyState ==
                                            WebSocket.connecting ||
                                        channel!.readyState ==
                                            WebSocket.closing)
                                      Positioned(
                                          child: Center(
                                              child: Text(
                                        Languages.of(context)!.connecting +
                                            '...',
                                        style: TextStyle(fontSize: 18),
                                      ))),
                                    if (downloadingFile)
                                      Positioned(
                                          child: Center(
                                              child: CircularProgressIndicator(
                                        strokeWidth: 10,
                                        backgroundColor: Colors.yellow,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.red),
                                        value: _progressValue,
                                      ))),
                                    if (loadingMessage)
                                      Positioned(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()))
                                  ]),
                            InkWell(
                                onTap: () async {},
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(19, 15, 15, 19),
                                  margin: EdgeInsets.only(top: 1),
                                  color: !themeState.isDarkTheme!
                                      ? Colors.white
                                      : Color.fromRGBO(40, 42, 45, 1),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "#" +
                                              (_appService.selectedChatRoomData !=
                                                      null
                                                  ? _appService
                                                      .selectedChatRoomData[
                                                          'offer']['id']
                                                      .toString()
                                                  : "") +
                                              ' - ' +
                                              (_appService.selectedChatRoomData !=
                                                      null
                                                  ? _appService
                                                          .selectedChatRoomData[
                                                      'offer']['title']
                                                  : ""),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: themeState.isDarkTheme ==
                                                      false
                                                  ? Color.fromRGBO(
                                                      41, 45, 50, 1)
                                                  : Color.fromRGBO(
                                                      205, 209, 214, 1)),
                                        ),
                                      ),
                                      if (_appService.selectedChatRoomData !=
                                          null)
                                        Text(
                                          _appService
                                                  .selectedChatRoomData['offer']
                                                      ['price']
                                                  .toString() +
                                              " " +
                                              (_appService.selectedChatRoomData[
                                                              'offer']
                                                          ['currency_type'] ==
                                                      null
                                                  ? ""
                                                  : _appService
                                                          .selectedChatRoomData[
                                                      'offer']['currency_type']),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromRGBO(
                                                  30, 163, 233, 1)),
                                        ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                        Container(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: themeState.isDarkTheme == true
                                            ? Color.fromRGBO(56, 59, 64, 1)
                                            : Color.fromARGB(
                                                255, 233, 233, 233)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _appService
                                              .selectedJobData['full_name'],
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: themeState.isDarkTheme ==
                                                      true
                                                  ? Color.fromRGBO(
                                                      212, 212, 212, 1)
                                                  : Color.fromARGB(
                                                      255, 54, 54, 54)),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_month_outlined,
                                                color: themeState.isDarkTheme ==
                                                        true
                                                    ? Color.fromRGBO(
                                                        212, 212, 212, 1)
                                                    : Color.fromARGB(
                                                        255, 54, 54, 54)),
                                            SizedBox(width: 10),
                                            Text(
                                              DateFormat.yMMMMd(myLocale
                                                              .countryCode
                                                              .toString()
                                                              .toLowerCase() ==
                                                          "us"
                                                      ? "en"
                                                      : myLocale.countryCode
                                                          .toString())
                                                  .add_jm()
                                                  .format(DateTime.parse(
                                                    _appService.selectedJobData[
                                                        'updated_on'],
                                                  )),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 13),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on_outlined,
                                                color: themeState.isDarkTheme ==
                                                        true
                                                    ? Color.fromRGBO(
                                                        212, 212, 212, 1)
                                                    : Color.fromARGB(
                                                        255, 54, 54, 54)),
                                            SizedBox(width: 10),
                                            Flexible(
                                                child: Text(
                                              _appService.selectedJobData[
                                                          'address'] ==
                                                      null
                                                  ? Languages.of(context)!
                                                      .no_city_info
                                                  : _appService.selectedJobData[
                                                      'address'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ))
                                          ],
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: 30,
                                ),
                                _appService.selectedJobData['questions'] != null
                                    ? _appService.selectedJobData['questions']
                                                .length ==
                                            0
                                        ? Container()
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                for (var question in _appService
                                                        .selectedJobData[
                                                    'questions'])
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          question[
                                                              'question_text'],
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      79,
                                                                      162,
                                                                      219,
                                                                      1),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(question['value']
                                                            .toString()),
                                                        SizedBox(height: 5),
                                                        Divider(
                                                          thickness: 1,
                                                          color: themeState
                                                                      .isDarkTheme ==
                                                                  true
                                                              ? Color.fromRGBO(
                                                                  51, 51, 51, 1)
                                                              : Color.fromRGBO(
                                                                  190,
                                                                  190,
                                                                  190,
                                                                  1),
                                                        ),
                                                        SizedBox(height: 5),
                                                      ])
                                              ],
                                            ))
                                    : Container(),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Description",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  79, 162, 219, 1),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          _appService
                                              .selectedJobData['description'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  194, 194, 194, 1)),
                                        ),
                                      ],
                                    )),
                                if (_appService.selectedJobData['files'] !=
                                        null &&
                                    _appService
                                            .selectedJobData['files'].length !=
                                        0)
                                  image_carousel,
                                _appService.selectedJobData['reviews_info'] ==
                                        null
                                    ? Container(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                          "No Offers",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  79, 162, 219, 1),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ))
                                    : _appService
                                                .selectedJobData['reviews_info']
                                                .length ==
                                            0
                                        ? Container(
                                            padding: EdgeInsets.all(20),
                                            child: Text(
                                              "No Offers",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      79, 162, 219, 1),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                        : Container(
                                            padding: EdgeInsets.all(20),
                                            child: Text(
                                              _appService
                                                      .selectedJobData[
                                                          'reviews_info']
                                                      .length
                                                      .toString() +
                                                  " Offers received",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      79, 162, 219, 1),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                _appService.selectedJobData['reviews_info'] !=
                                            null &&
                                        _appService
                                                .selectedJobData['reviews_info']
                                                .length !=
                                            0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: _appService
                                            .selectedJobData['reviews_info']
                                            .length,
                                        itemBuilder: (ctx, index) => Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: Row(children: [
                                              RatingBar.builder(
                                                initialRating: double.parse(
                                                    _appService.selectedJobData[
                                                            'reviews_info']
                                                            [index]['medie']
                                                        .toString()),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                ignoreGestures: true,
                                                itemSize: 20,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 0.1),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(_appService.selectedJobData[
                                                      'reviews_info'][index]
                                                      ['medie']
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('[ REVIEWS: ' +
                                                  _appService.selectedJobData[
                                                          'reviews_info'][index]
                                                          ['count']
                                                      .toString() +
                                                  ' ]')
                                            ])),
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Text(
                                            "Be the first to send offer",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromRGBO(
                                                    194, 194, 194, 1)))),
                              ],
                            ),
                          ),
                        ),
                      ]))));
        });
  }

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
}
