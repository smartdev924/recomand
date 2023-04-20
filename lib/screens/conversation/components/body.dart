import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/size_config.dart';
import 'package:provider/provider.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/theme/theme_colors.dart';
import './conversation_card.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Body extends StatefulWidget {
  const Body(
      // key? key,
      );
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  bool isLoaded = false;
  dynamic chatList = [];
  bool isLoadMoreConversation = false;
  ScrollController conversationScrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    _appService = Provider.of<AppService>(context, listen: false);
    getMyChatRooms();
    conversationScrollController.addListener(() {
      if (conversationScrollController.position.pixels ==
          conversationScrollController.position.maxScrollExtent) {
        if (!isLoadMoreConversation) loadMoreConversation();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    conversationScrollController.dispose();
  }

  Future<void> loadMoreConversation() async {
    setState(() {
      isLoadMoreConversation = true;
    });
    dynamic response =
        await _appService.getMyChatRooms(offset: chatList.length);
    if (response is String || response == null) {
      setState(() {
        isLoadMoreConversation = false;
      });
      return;
    } else {
      setState(() {
        chatList.addAll(response.data['data'].reversed.toList());

        isLoadMoreConversation = false;
      });
    }
  }

  Future<void> getMyChatRooms() async {
    dynamic response = await _appService.getMyChatRooms();
    if (response is String || response == null) {
      setState(() {
        chatList = null;
        isLoaded = true;
      });
      return;
    } else {
      setState(() {
        chatList = response.data['data'].reversed.toList();
        isLoaded = true;
      });
    }
  }

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      child: Container(
        child: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
              ),
              onPressed: () {
                if (_appService.user['is_worker'] == false)
                  GoRouter.of(context).pushNamed(APP_PAGE.home.toName);
                else if (_appService.user['user_type'] == 'hire')
                  GoRouter.of(context).pushNamed(APP_PAGE.home.toName);
                else if (_appService.user['credits'] != 0)
                  GoRouter.of(context)
                      .pushNamed(APP_PAGE.browseRequests.toName);
              }),
          elevation: 0.0,
          title: Column(
            children: [
              Text(
                Languages.of(context)!.conversations,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(22),
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: !isLoaded
            ? Center(
                child: Container(
                width: 100,
                child: LoadingIndicator(
                    indicatorType: Indicator.orbit,

                    /// Required, The loading type of the widget
                    colors: [
                      context
                          .watch<AppService>()
                          .themeState
                          .customColors[AppColors.loadingIndicatorColor]!
                    ],

                    /// Optional, The color collections
                    strokeWidth: 2,

                    /// Optional, The stroke of the line, only applicable to widget which contains line
                    backgroundColor: Colors.transparent,

                    /// Optional, Background of the widget
                    pathBackgroundColor: context
                        .watch<AppService>()
                        .themeState
                        .customColors[AppColors.loadingIndicatorBackgroundColor]

                    /// Optional, the stroke backgroundColor
                    ),
              ))
            : chatList == null || chatList?.length == 0
                ? Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mark_unread_chat_alt_outlined,
                        size: 30,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        Languages.of(context)!.nochattingroom,
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: 250,
                        child: _appService.user['is_worker'] &&
                                _appService.user['user_type'] == "work"
                            ? DefaultButton(
                                text: Languages.of(context)!.goBrowserPage,
                                press: (() {
                                  if (_appService.user['credits'] != 0)
                                    GoRouter.of(context).pushNamed(
                                        APP_PAGE.browseRequests.toName);
                                  else if (Platform.isIOS) {
                                    GoRouter.of(context).pushNamed(
                                        APP_PAGE.buyCreditsApple.toName);
                                  } else {
                                    GoRouter.of(context)
                                        .pushNamed(APP_PAGE.buyCredits.toName);
                                  }
                                }))
                            : DefaultButton(
                                text: Languages.of(context)!.gohomepage,
                                press: (() {
                                  GoRouter.of(context)
                                      .pushNamed(APP_PAGE.home.toName);
                                })),
                      )
                    ],
                  ))
                : Column(
                    children: [
                      Flexible(
                          child: RefreshIndicator(
                              child: ListView.builder(
                                  itemCount: chatList.length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  controller: conversationScrollController,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ConversationCard(
                                        chatRoomData: chatList[index]);
                                  }),
                              onRefresh: () {
                                return getMyChatRooms();
                              })),
                      if (isLoadMoreConversation)
                        Container(
                            child: Center(
                          child: CircularProgressIndicator(),
                        ))
                    ],
                  ));
  }
}
