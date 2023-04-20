import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ConversationCard extends StatefulWidget {
  final chatRoomData;
  const ConversationCard(
      // key? key,
      {
    required this.chatRoomData,
  });
  @override
  _ConversationCardState createState() => _ConversationCardState();
}

class _ConversationCardState extends State<ConversationCard> {
  // var _popupMenuItemIndex = 0;
  late AppService _appService;
  // bool isLoaded = false;
  dynamic productData;

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    super.initState();
  }

  Future<void> deleteChatroom() async {
    await _appService.deleteChatroomByID(roomID: widget.chatRoomData['id']);

    // setState(() => isLoaded = true);
  }

  Future<void> achiveChatroom() async {
    await _appService.archiveChatroomByID(roomID: widget.chatRoomData['id']);
  }

  _onMenuItemSelected(int value) {
    setState(() {
      // _popupMenuItemIndex = value;
    });

    if (value == 1) {
      achiveChatroom();
    }
    if (value == 2) {
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(Languages.of(context)!.cancel_btn),
      onPressed: () {
        GoRouter.of(context).pushNamed(APP_PAGE.conversation.toName);
      },
    );
    Widget continueButton = TextButton(
      child: Text(Languages.of(context)!.delete_btn),
      onPressed: () {
        deleteChatroom();
        GoRouter.of(context).pushNamed(APP_PAGE.conversation.toName);
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Languages.of(context)!.areyousure),
      content: Text(Languages.of(context)!.delete_description),
      actions: [
        cancelButton,
        continueButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _appService.selectedChatRoomData = widget.chatRoomData['room'];

        if (_appService.user['is_worker'] == true &&
            _appService.user['user_type'] == "work") {
          _appService.selectedChatUser = widget.chatRoomData['user'];
          dynamic response = await _appService.getRequestById(
              requestID: widget.chatRoomData['offer']['request_id']);
          if (response is String || response == null) {
            showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message: response,
                ));
            return;
          } else {
            _appService.selectedJobData = response.data;
          }
          if (kIsWeb) {
            GoRouter.of(context)
                .pushReplacementNamed(APP_PAGE.workChatView.toName);
          } else if (Platform.isAndroid || Platform.isIOS) {
            GoRouter.of(context)
                .pushReplacementNamed(APP_PAGE.workChatView.toName);
          } else {
            GoRouter.of(context)
                .pushReplacementNamed(APP_PAGE.workChatViewDesktop.toName);
          }
        } else {
          _appService.selectedChatUser = widget.chatRoomData['expert'];

          if (kIsWeb) {
            GoRouter.of(context).pushReplacementNamed(APP_PAGE.chatView.toName);
          } else if (Platform.isAndroid || Platform.isIOS) {
            GoRouter.of(context).pushReplacementNamed(APP_PAGE.chatView.toName);
          } else {
            GoRouter.of(context)
                .pushReplacementNamed(APP_PAGE.chatViewDekstop.toName);
          }
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 15, 10, 9),
        decoration: BoxDecoration(
          color: context.watch<AppService>().themeState.isDarkTheme == false
              ? Color.fromRGBO(242, 243, 245, 1)
              : Colors.black,
          border: Border(
            bottom: BorderSide(
                width: 1.0, color: Color.fromRGBO(137, 138, 143, 0.5)),
          ),
        ),
        child: _appService.user == null
            ? SizedBox()
            : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                AdvancedAvatar(
                  size: 66,
                  image: _appService.user['is_worker'] == true &&
                          _appService.user['user_type'] == "work"
                      ? (widget.chatRoomData['user']['avatar'] == null ||
                              widget.chatRoomData['user']['avatar'] == "")
                          ? AssetImage('assets/images/user.png')
                          : ExtendedImage.network(
                              widget.chatRoomData['user']['avatar'],
                              clearMemoryCacheIfFailed: true,
                              clearMemoryCacheWhenDispose: true,
                              loadStateChanged: (ExtendedImageState state) {
                                switch (state.extendedImageLoadState) {
                                  case LoadState.failed:
                                    return Image.asset(
                                      'assets/images/profile_sm.png',
                                    );

                                  case LoadState.loading:
                                    return Image.asset(
                                      'assets/images/profile_sm.png',
                                    );
                                  case LoadState.completed:
                                    break;
                                }
                                return null;
                              },
                            ).image
                      : (widget.chatRoomData['expert']['avatar'] == null ||
                              widget.chatRoomData['expert']['avatar'] == "")
                          ? AssetImage('assets/images/user.png')
                          : ExtendedImage.network(
                              widget.chatRoomData['expert']['avatar'],
                              clearMemoryCacheIfFailed: true,
                              clearMemoryCacheWhenDispose: true,
                              loadStateChanged: (ExtendedImageState state) {
                                switch (state.extendedImageLoadState) {
                                  case LoadState.failed:
                                    return Image.asset(
                                      'assets/images/user.png',
                                    );

                                  case LoadState.loading:
                                    return Image.asset(
                                      'assets/images/user.png',
                                    );
                                  case LoadState.completed:
                                    break;
                                }
                                return null;
                              },
                            ).image,
                  statusColor: _appService.user['is_worker'] == true &&
                          _appService.user['user_type'] == "work"
                      ? widget.chatRoomData['user']['is_online']
                          ? Color.fromRGBO(76, 217, 100, 1)
                          : Color.fromRGBO(139, 139, 151, 1)
                      : widget.chatRoomData['expert']['is_online']
                          ? Color.fromRGBO(76, 217, 100, 1)
                          : Color.fromRGBO(139, 139, 151, 1),
                  statusAngle: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _appService.user['is_worker'] == true &&
                              _appService.user['user_type'] == "work"
                          ? widget.chatRoomData['user']['full_name'] == null
                              ? ""
                              : widget.chatRoomData['user']['full_name']
                          : widget.chatRoomData['expert']['full_name'] == null
                              ? ""
                              : widget.chatRoomData['expert']['full_name'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      _appService.user['is_worker'] == true &&
                              _appService.user['user_type'] == "work"
                          ? widget.chatRoomData['user']['profesion']
                          : widget.chatRoomData['expert']['profesion'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(137, 138, 143, 1)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.chatRoomData['last_update'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(100, 174, 223, 1)),
                    ),
                  ],
                )),
                Column(
                  children: [
                    if (widget.chatRoomData['unread_count'] != 0)
                      Container(
                        width: 25,
                        alignment: Alignment.center,
                        height: 25,
                        child: Text(
                          widget.chatRoomData['unread_count'] > 99
                              ? "99."
                              : widget.chatRoomData['unread_count'].toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 233, 233, 233),
                              fontWeight: FontWeight.w600),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(255, 211, 67, 10)),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    PopupMenuButton(
                        onSelected: (value) {
                          _onMenuItemSelected(value as int);
                        },
                        // initialValue: 2,
                        child: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Text(Languages.of(context)!.archiveroom),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text(Languages.of(context)!.deleteroom),
                              )
                            ]),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ]),
      ),
    );
  }
}
