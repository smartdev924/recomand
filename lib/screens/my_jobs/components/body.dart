import 'dart:async';
import 'package:flutter/material.dart';
import 'package:localservice/size_config.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'my_jobs_item_card.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:go_router/go_router.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  bool isLoaded = false;
  bool sortOption = true;
  ScrollController jobScrollController = ScrollController();
  dynamic myJobList;
  bool isLoadMoreJobs = false;

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    getMyJobs(is_active: sortOption);
    jobScrollController.addListener(() {
      if (jobScrollController.position.pixels ==
          jobScrollController.position.maxScrollExtent) {
        if (!isLoadMoreJobs) loadMoreJobs();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    jobScrollController.dispose();
  }

  Future<void> loadMoreJobs() async {
    setState(() => {isLoadMoreJobs = true});
    dynamic response = await _appService.getMyRequests(
        offset: myJobList.length, is_active: sortOption);

    if (response is String || response == null) {
      setState(() {
        isLoadMoreJobs = false;
      });
      return;
    }

    setState(() {
      isLoadMoreJobs = false;
      myJobList.addAll(response.data['data']);
    });
  }

  Future<void> getMyJobs({bool is_active = true}) async {
    if (!mounted) return;
    setState(() => {isLoaded = false});

    dynamic response = await _appService.getMyRequests();
    if (response is String || response == null) {
      myJobList = null;
      setState(() {
        isLoaded = true;
      });
      return;
    }

    myJobList = response.data['data'];
    setState(() {
      isLoaded = true;
    });
  }

  // ignore: unused_field
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: Container(
            padding: EdgeInsets.all(10),
            color: context.watch<AppService>().themeState.isDarkTheme == false
                ? Color.fromRGBO(249, 249, 255, 1)
                : context
                    .watch<AppService>()
                    .themeState
                    .customColors[AppColors.primaryBackgroundColor],
            child: Column(children: <Widget>[
              isLoaded
                  ? myJobList != null && myJobList.length != 0
                      ? Flexible(
                          child: RefreshIndicator(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: jobScrollController,
                                  physics: ScrollPhysics(),
                                  itemCount: myJobList.length,
                                  itemBuilder: (ctx, index) => MyJobsItemCard(
                                        index: index,
                                        data: myJobList[index],
                                        is_active: sortOption,
                                      )),
                              onRefresh: () {
                                return getMyJobs();
                              }))
                      : Center(
                          child: Column(children: [
                          SizedBox(
                            height: 55,
                          ),
                          Image.asset(
                            'assets/images/no_jobs.png',
                            fit: BoxFit.cover,
                            width: 111,
                            // height: double.infinity,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            Languages.of(context)!.noJobs,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: context
                                            .watch<AppService>()
                                            .themeState
                                            .isDarkTheme ==
                                        false
                                    ? Color.fromRGBO(43, 44, 46, 1)
                                    : Colors.white70),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            Languages.of(context)!.noRequestDesc,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: context
                                            .watch<AppService>()
                                            .themeState
                                            .isDarkTheme ==
                                        false
                                    ? Color.fromRGBO(43, 44, 46, 1)
                                    : Colors.white70),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(79, 162, 219, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                Languages.of(context)!.browseServices,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed(APP_PAGE.home.toName);
                            },
                          )
                        ]))
                  : Expanded(
                      child: Center(
                      child: CircularProgressIndicator(),
                    )),
              if (isLoadMoreJobs)
                Container(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator())
            ])));
  }

  AppBar appBar(
    BuildContext context,
  ) {
    return AppBar(
      centerTitle: true,
      leading: Container(),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: PopupMenuButton(
              onSelected: (value) {
                _onMenuItemSelected(value as int);
              },
              // initialValue: 2,
              child: Icon(
                Icons.sort_sharp,
                size: 25,
                color:
                    context.watch<AppService>().themeState.isDarkTheme == false
                        ? Colors.black
                        : Colors.white70,
              ),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        Languages.of(context)!.ACTIVE,
                        style: TextStyle(
                            color: context
                                .watch<AppService>()
                                .themeState
                                .customColors[AppColors.primaryTextColor1]),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text(Languages.of(context)!.CANCELED,
                          style: TextStyle(
                              color: context
                                  .watch<AppService>()
                                  .themeState
                                  .customColors[AppColors.primaryTextColor1])),
                    )
                  ]),
        )
      ],
      title: Column(
        children: [
          Text(
            Languages.of(context)!.my_jobs,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  _onMenuItemSelected(int value) {
    setState(() {
      // _popupMenuItemIndex = value;
    });

    if (value == 1) {
      setState(() {
        isLoaded = false;
        sortOption = true;
      });
      getMyJobs(is_active: sortOption);
    }
    if (value == 2) {
      setState(() {
        sortOption = false;
        isLoaded = false;
      });
      getMyJobs(is_active: sortOption);
      ;
    }
  }
}
