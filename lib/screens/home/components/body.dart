import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localservice/constants.dart';

import 'package:localservice/screens/home/components/service_list.dart';
import 'package:localservice/size_config.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatefulWidget {
  const Body(
      // key? key,
      );
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  dynamic homePageData = [];
  dynamic reserveHomePageData = [];
  dynamic filterdServices = [];
  late AppService _appService;
  TextEditingController eCtrl = TextEditingController();

  bool isLoaded = false;
  bool noResult = false;
  bool isSearching = false;
  String mToken = '';
  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();
  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    initializeData();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeData() async {
    _appService.loadLocalData();
    if (_appService.homePageData == null) {
      dynamic response = await _appService.getAllServices1();
      if (response is String || response == null) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: response,
          ),
        );
        setState(() => isLoaded = true);
        return;
      }
      setState(() {
        homePageData = response.data;
      });
    } else
      setState(() {
        homePageData = _appService.homePageData;
      });

    if (!mounted) return;
    setState(() => isLoaded = true);
  }

  Future<void> refreshLocalData() async {
    eCtrl.text = "";
    dynamic response = await _appService.getAllServices1();
    if (response is String || response == null) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: response,
        ),
      );
      setState(() => isLoaded = true);
      return;
    }
    if (!mounted) return;
    setState(() {
      homePageData = _appService.homePageData;
      reserveHomePageData = _appService.homePageData;
    });
    setState(() => isLoaded = true);
  }

  Future<void> filterService(String key) async {
    _appService.loadLocalData();
    setState(() {
      reserveHomePageData = _appService.homePageData;
    });
    if (key == "") {
      setState(() {
        filterdServices = [];
      });
      return;
    }
    for (int i = 0; i < reserveHomePageData.length; i++) {
      reserveHomePageData[i]['services'].removeWhere((element) =>
          !removeDiacritics(element["name"].toString())
              .toLowerCase()
              .contains(key.toLowerCase()));
    }
    setState(() {
      filterdServices = [];
    });

    for (int i = 0; i < reserveHomePageData.length; i++)
      for (int j = 0; j < reserveHomePageData[i]['services'].length; j++) {
        setState(() {
          filterdServices.add(reserveHomePageData[i]['services'][j]);
        });
      }
    if (!mounted) return;
  }

  Future<void> searchService(String key) async {
    _appService.loadLocalData();
    setState(() {
      isSearching = true;
      noResult = false;
      homePageData = _appService.homePageData;
    });

    for (int i = 0; i < homePageData.length; i++) {
      homePageData[i]['services'].removeWhere((element) =>
          !removeDiacritics(element["name"].toString())
              .toLowerCase()
              .contains(key.toLowerCase()));
    }
    bool flag = true;
    for (int i = 0; i < homePageData.length; i++)
      if (homePageData[i]['services'].length != 0) flag = false;
    setState(() {
      noResult = flag;
    });
    if (!mounted) return;
    setState(() => isSearching = false);
  }

  Future<void> selectService(String key) async {
    _appService.loadLocalData();
    setState(() {
      isSearching = true;
      noResult = false;
      homePageData = _appService.homePageData;
    });

    for (int i = 0; i < homePageData.length; i++) {
      homePageData[i]['services'].removeWhere((element) =>
          element["name"].toString().toLowerCase() != key.toLowerCase());
    }
    bool flag = true;
    for (int i = 0; i < homePageData.length; i++)
      if (homePageData[i]['services'].length != 0) flag = false;
    setState(() {
      noResult = flag;
    });
    if (!mounted) return;
    setState(() => isSearching = false);
  }

  Future<void> reloadHomePageData() async {
    eCtrl.text = "";
    final response = await _appService.getAllServices1();
    if (response is String || response == null) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: response,
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    _appService.contextData = context;

    return SafeArea(
        child: isLoaded
            ? RefreshIndicator(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 34, bottom: 10),
                      margin: EdgeInsets.only(top: 0),
                      color:
                          context.watch<AppService>().themeState.isDarkTheme ==
                                  true
                              ? Color.fromRGBO(89, 124, 229, 1)
                              : Color.fromRGBO(67, 107, 225, 1),
                      width: double.infinity,
                      child: TextFormField(
                        controller: eCtrl,
                        onFieldSubmitted: (value) async {
                          searchService(value);
                        },
                        onChanged: (value) async {
                          filterService(value);
                        },
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.always,
                        textInputAction: TextInputAction.none,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(10),
                              vertical: getProportionateScreenHeight(19),
                            ),
                            hintText: Languages.of(context)!.which_service,
                            hintStyle: TextStyle(
                                color: context
                                            .watch<AppService>()
                                            .themeState
                                            .isDarkTheme ==
                                        false
                                    ? Color.fromRGBO(0, 0, 0, 0.5)
                                    : Color.fromRGBO(255, 255, 255, 0.5)),
                            prefixIcon: Icon(Icons.search),
                            suffix: isSearching
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator())
                                : Text(""),
                            fillColor: context
                                        .watch<AppService>()
                                        .themeState
                                        .isDarkTheme ==
                                    false
                                ? Color.fromRGBO(242, 243, 245, 1)
                                : Color.fromRGBO(24, 24, 24, 1),
                            iconColor: Color.fromRGBO(0, 0, 0, 0.2),
                            filled: true),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Stack(
                        children: <Widget>[
                          noResult
                              ? Center(
                                  child: Text(Languages.of(context)!.noService))
                              : SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i < homePageData.length;
                                          i++)
                                        if (homePageData[i]['services']
                                                .length !=
                                            0)
                                          ServiceList(
                                              serviceList: homePageData[i]),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                          if (filterdServices.length != 0)
                            Container(
                              width: double.infinity,
                              height: 250,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              color: Color.fromARGB(255, 247, 247, 247),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: filterdServices.length,
                                itemBuilder: (ctx, index) => Container(
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  child: InkWell(
                                    onTap: () {
                                      selectService(
                                          filterdServices[index]['name']);
                                      eCtrl.text =
                                          filterdServices[index]['name'];
                                      filterService("");
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 233, 233, 233)),
                                        child: Text(
                                          filterdServices[index]['name']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
                onRefresh: () {
                  return refreshLocalData();
                })
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
