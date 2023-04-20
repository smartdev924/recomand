import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum Menu { home, browseRequests, message, profile, addproduct }

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({
    Key? key,
    this.selectedMenu,
    this.userType,
  }) : super(key: key);

  final Menu? selectedMenu;
  final bool? userType;
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final Color inActiveColor = Color.fromRGBO(57, 58, 60, 1);
  late AppService _appService;
  bool showNewMessage = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _appService = Provider.of<AppService>(context, listen: false);
    if (_appService.loginState == true) {
      if (_appService.user['is_worker'] == false) {
        setState(() {
          if (widget.selectedMenu == Menu.home) selectedIndex = 0;
          if (widget.selectedMenu == Menu.browseRequests) selectedIndex = 1;
          if (widget.selectedMenu == Menu.message) selectedIndex = 2;
          if (widget.selectedMenu == Menu.profile) selectedIndex = 3;
        });
      } else {
        if (_appService.user['user_type'] == "hire") {
          setState(() {
            if (widget.selectedMenu == Menu.home) selectedIndex = 0;
            if (widget.selectedMenu == Menu.browseRequests) selectedIndex = 1;
            if (widget.selectedMenu == Menu.message) selectedIndex = 2;
            if (widget.selectedMenu == Menu.profile) selectedIndex = 3;
          });
        } else {
          setState(() {
            if (widget.selectedMenu == Menu.browseRequests) selectedIndex = 0;
            if (widget.selectedMenu == Menu.message) selectedIndex = 1;
            if (widget.selectedMenu == Menu.profile) selectedIndex = 2;
          });
        }
      }
    } else {
      setState(() {
        if (widget.selectedMenu == Menu.home) selectedIndex = 0;
        if (widget.selectedMenu == Menu.browseRequests) selectedIndex = 1;
        if (widget.selectedMenu == Menu.message) selectedIndex = 2;
        if (widget.selectedMenu == Menu.profile) selectedIndex = 3;
      });
    }
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        FirebaseMessaging.onMessageOpenedApp
            .listen((RemoteMessage message) async {
          if (message.data.isNotEmpty) {
            if (message.data['room_id'] != null &&
                message.data['type'] == "new_message") {
              showNewMessage = true;
              setState(() {});
              if (kIsWeb) {
                GoRouter.of(context).pushNamed(APP_PAGE.directChatView.toName,
                    params: {"roomID": message.data['room_id']});
              } else if (Platform.isAndroid || Platform.isIOS) {
                GoRouter.of(context).pushNamed(APP_PAGE.directChatView.toName,
                    params: {"roomID": message.data['room_id']});
              } else {
                GoRouter.of(context).pushNamed(APP_PAGE.directChatView.toName,
                    params: {"roomID": message.data['room_id']});
              }
              return;
            }
            if (message.data['type'] == 'new_offer' &&
                message.data['offer_id'] != null) {
              _appService.receivedNewNotification = true;
              GoRouter.of(context).pushNamed(APP_PAGE.directMyJobOfferID.toName,
                  params: {"offerID": message.data['offer_id']});
              return;
            }
            if (message.data['request_id'] != null &&
                message.data['type'] == 'new_request') {
              _appService.receivedNewNotification = true;
              GoRouter.of(context).pushNamed(APP_PAGE.directJobDetails.toName,
                  params: {"requestID": message.data['request_id']});
              return;
            }
          }
        });
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
          String? str = '';
          String? title = '';
          if (message.notification?.body == null) {
            str = '';
            return;
          } else {
            str = message.notification?.body;
            title = message.notification?.title;
          }
          if (GoRouter.of(context).location.contains('chat-view') &&
              _appService.selectedChatRoomData['id'].toString() ==
                  message.data['room_id'].toString()) {
            return;
          } else {
            if (title.toString().toLowerCase().contains("message")) {
              setState(() {
                showNewMessage = true;
              });
              return;
            }
            _appService.receivedNewNotification = true;
            showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.info(
                  message: str!,
                ), onTap: () {
              if (message.data['type'] == 'new_offer' &&
                  message.data['offer_id'] != null) {
                GoRouter.of(context).pushNamed(
                    APP_PAGE.directMyJobOfferID.toName,
                    params: {"offerID": message.data['offer_id']});
                return;
              }

              if (message.data['request_id'] != null &&
                  message.data['type'] == 'new_request') {
                _appService.fromPushNotification = true;
                GoRouter.of(context).pushNamed(APP_PAGE.directJobDetails.toName,
                    params: {"requestID": message.data['request_id']});
                return;
              }
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _appService.user == null
        ? Container()
        : BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: _appService.user['is_worker'] == false
                ? [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        size: 30,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.bookmark_border_outlined,
                        size: 30,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Stack(children: [
                        Icon(
                          Icons.question_answer,
                          size: 30,
                        ),
                        if (showNewMessage)
                          Positioned(
                              right: 0,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ))
                      ]),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        size: 30,
                      ),
                      label: '',
                    ),
                  ]
                : _appService.user['user_type'] != "work"
                    ? [
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home,
                            size: 30,
                          ),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.bookmark_border_outlined,
                            size: 30,
                          ),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Stack(children: [
                            Icon(
                              Icons.question_answer,
                              size: 30,
                            ),
                            if (showNewMessage)
                              Positioned(
                                  right: 0,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ))
                          ]),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.person,
                            size: 30,
                          ),
                          label: '',
                        ),
                      ]
                    : [
                        BottomNavigationBarItem(
                          icon: selectedIndex == 0
                              ? new Image.asset(
                                  'assets/images/seller.png',
                                  color: Color.fromRGBO(79, 162, 219, 1),
                                )
                              : new Image.asset('assets/images/seller.png'),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Stack(children: [
                            Icon(
                              Icons.question_answer,
                              size: 30,
                            ),
                            if (showNewMessage)
                              Positioned(
                                  right: 0,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ))
                          ]),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.person,
                            size: 30,
                          ),
                          label: '',
                        ),
                      ],
            currentIndex: _appService.user['is_worker'] == true &&
                    _appService.user['user_type'] == "work" &&
                    selectedIndex > 2
                ? (selectedIndex - 1)
                : selectedIndex,
            selectedItemColor: Color.fromRGBO(79, 162, 219, 1),
            unselectedItemColor: Color.fromARGB(255, 122, 122, 122),
            onTap: (int index) {
              setState(
                () {
                  selectedIndex = index;
                },
              );
              if (_appService.user['is_worker'] == false) {
                switch (index) {
                  case 0:
                    GoRouter.of(context).pushNamed(APP_PAGE.home.toName);
                    break;
                  case 1:
                    GoRouter.of(context).pushNamed(APP_PAGE.myJobs.toName);
                    break;
                  case 2:
                    GoRouter.of(context)
                        .pushNamed(APP_PAGE.conversation.toName);
                    break;
                  case 3:
                    GoRouter.of(context)
                        .pushNamed(APP_PAGE.myAccountSettings.toName);
                    break;
                }
              } else {
                if (_appService.user['user_type'] == "hire") {
                  switch (index) {
                    case 0:
                      GoRouter.of(context).pushNamed(APP_PAGE.home.toName);
                      break;
                    case 1:
                      GoRouter.of(context).pushNamed(APP_PAGE.myJobs.toName);

                      break;
                    case 2:
                      GoRouter.of(context)
                          .pushNamed(APP_PAGE.conversation.toName);
                      break;
                    case 3:
                      GoRouter.of(context)
                          .pushNamed(APP_PAGE.myAccountSettings.toName);
                      break;
                  }
                } else {
                  switch (index) {
                    // case 0:
                    //   GoRouter.of(context).pushNamed(APP_PAGE.home.toName);
                    //   break;
                    case 0:
                      // if (_appService.user['credits'] == 0) {
                      //   if (Platform.isIOS) {
                      //     GoRouter.of(context)
                      //         .pushNamed(APP_PAGE.buyCreditsApple.toName);
                      //   } else {
                      //     GoRouter.of(context)
                      //         .pushNamed(APP_PAGE.buyCredits.toName);
                      //   }
                      // } else {
                      GoRouter.of(context)
                          .pushNamed(APP_PAGE.browseRequests.toName);
                      // }
                      break;
                    case 1:
                      GoRouter.of(context)
                          .pushNamed(APP_PAGE.conversation.toName);

                      break;
                    case 2:
                      GoRouter.of(context)
                          .pushNamed(APP_PAGE.myAccountSettings.toName);
                      break;
                  }
                }
              }
            },
          );
  }
}
