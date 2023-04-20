import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/screens/notifications/components/notification_item_card.dart';
import 'package:localservice/services/AppService.dart';
import 'package:provider/provider.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoaded = false;
  dynamic notificationList;
  dynamic notificationList_reverse;
  ScrollController notificationScrollController = ScrollController();
  // dynamic recentList = [];
  // dynamic monthList = [];
  // dynamic earlierList = [];

  late AppService _appService;

  final formatter = DateFormat('EEE, d MMM yyyy HH:mm:ss');
  final formatter1 = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateTime selectedDate = DateTime.now();
  String dateAgo = '';
  bool isLoadMoreNotfications = false;
  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    getNotifications();
    notificationScrollController.addListener(() {
      if (notificationScrollController.position.pixels ==
          notificationScrollController.position.maxScrollExtent) {
        if (!isLoadMoreNotfications) loadMoreNotifcations();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    notificationScrollController.dispose();
    super.dispose();
  }

  Future<void> loadMoreNotifcations() async {
    setState(() {
      isLoadMoreNotfications = true;
    });
    dynamic response =
        await _appService.getNotifications(offset: notificationList.length);
    if (!mounted) return;

    if (response is String || response == null) {
      setState(() {
        isLoadMoreNotfications = false;
      });
      return;
    }
    setState(
      () {
        isLoadMoreNotfications = false;
        notificationList_reverse = response.data['data'];
        notificationList.addAll(notificationList_reverse.reversed.toList());
      },
    );
  }

  Future<void> getNotifications() async {
    dynamic response = await _appService.getNotifications();
    if (!mounted) return;

    if (response is String || response == null) {
      notificationList = null;
      setState(() {
        isLoaded = true;
      });
      return;
    }
    setState(
      () {
        notificationList_reverse = response.data['data'];
        notificationList = notificationList_reverse.reversed.toList();
      },
    );

    setState(() {
      isLoaded = true;
    });
  }

  int displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    if (diffInHours < 1) {
      return 0;
    } else if (diffInHours < 24) {
      return 0;
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      return 1;
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      return 1;
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      return 2;
    } else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: !isLoaded
            ? Center(
                child: Container(
                width: 100,
                child: LoadingIndicator(
                    indicatorType: Indicator.ballScaleRippleMultiple,

                    /// Required, The loading type of the widget
                    colors: [
                      context
                          .watch<AppService>()
                          .themeState
                          .customColors[AppColors.loadingIndicatorColor]!
                    ],
                    strokeWidth: 2,
                    backgroundColor: Colors.transparent,
                    pathBackgroundColor:
                        context.watch<AppService>().themeState.customColors[
                            AppColors.loadingIndicatorBackgroundColor]),
              ))
            : (notificationList == null || notificationList.length == 0)
                ? Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Image.asset(
                          'assets/images/no_notification.png',
                          fit: BoxFit.cover,
                          width: 77,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        Languages.of(context)!.noNotification,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        child: Text(
                          Languages.of(context)!.notificationDesc,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(176, 176, 176, 1)),
                        ),
                      )
                    ],
                  ))
                : Container(
                    color: !context.watch<AppService>().themeState.isDarkTheme!
                        ? Color.fromRGBO(247, 247, 247, 1)
                        : Color.fromRGBO(0, 0, 0, 0.5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                              child: RefreshIndicator(
                                  child: // PushItemCard(notiItem: null),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          controller:
                                              notificationScrollController,
                                          physics: ScrollPhysics(),
                                          itemCount: notificationList.length,
                                          itemBuilder: (ctx, index) =>
                                              Container(
                                                child: NotficationItemCard(
                                                    notiItem: notificationList[
                                                        index]),
                                              )),
                                  onRefresh: () {
                                    return getNotifications();
                                  })),
                          if (isLoadMoreNotfications)
                            Container(
                                padding: EdgeInsets.all(10),
                                child:
                                    Center(child: CircularProgressIndicator()))
                        ])));
  }
}
