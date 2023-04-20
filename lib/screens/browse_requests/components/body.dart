import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/size_config.dart';
import 'package:provider/provider.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import './request_item_card.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  bool isLoaded = false;
  bool isSearching = false;
  dynamic requestList;
  bool showFilterBar = false;
  bool loadingCities = false;
  String selectedFilterItem = 'All';
  String searchKeyString = "";
  final TextEditingController searchTextCtrl = TextEditingController();
  ScrollController borwseScrollController = ScrollController();
  String mToken = '';
  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();
  static const List<String> priorityList = <String>[
    "All",
    "FREE",
    "HIGH",
  ];
  List<String> priorityFilterList = <String>[];
  dynamic cityList = [];
  String priority_key = priorityList.first;
  String priority_translated_key = '';
  dynamic service_key = null;
  String city_key = "";
  dynamic selected_city = null;
  dynamic serviceList;
  bool isLoadMoreRequests = false;

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    getServiceList();
    borwseScrollController.addListener(() {
      if (borwseScrollController.position.pixels ==
          borwseScrollController.position.maxScrollExtent) {
        if (!isLoadMoreRequests) loadMoreRequests();
      }
    });

    setState(() {
      searchKeyString = _appService.keywords;
    });
    searchTextCtrl.text = _appService.keywords;
    loadRequests();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> refreshRequests() async {
    getServiceList();
    searchTextCtrl.text = _appService.keywords;
    loadRequests();
  }

  Future<void> searchCity(String city_key) async {
    final response = await _appService.locationAutoComplete(city: city_key);
    if (response is String || response == null) {
      setState(() {});
    } else {
      setState(() {
        dynamic data = response.data['data'];
        cityList = [];
        for (int i = 0; i < data.length; i++) {
          cityList.add({
            'selected': false,
            'id': data[i]['city']['id'],
            'name': data[i]['city']['name']
          });
        }
      });
    }
  }

  Future<void> loadMoreRequests() async {
    setState(() => {isLoadMoreRequests = true});
    dynamic response = await _appService.browseRequests(
        searchKey: searchKeyString,
        priority: priority_key == "All" ? null : priority_key,
        service_id: service_key == null ? null : service_key['id'],
        city_id: selected_city == null ? null : selected_city['id'],
        offset: requestList.length);
    if (!mounted) return;

    if (response is String || response == null) {
      setState(() {
        isLoadMoreRequests = false;
      });
      return;
    }

    setState(() {
      isLoadMoreRequests = false;
      requestList.addAll(response.data['data']);
    });
  }

  @override
  void dispose() {
    searchTextCtrl.dispose();
    borwseScrollController.dispose();
    super.dispose();
  }

  Future<void> getServiceList() async {
    final response = await _appService.getAllServices();
    if (response is String || response == null) {
      setState(() {});
    } else {
      setState(() {
        dynamic data = response.data['data'];
        serviceList = data;
      });
    }
  }

  Future<void> loadRequests() async {
    setState(() {
      isLoaded = false;
    });

    dynamic response = await _appService.browseRequests(
      searchKey: searchKeyString,
      priority: priority_key == "All" ? null : priority_key,
      service_id: service_key == null ? null : service_key['id'],
      city_id: selected_city == null ? null : selected_city['id'],
    );
    if (!mounted) return;

    if (response is String || response == null) {
      requestList = null;
      setState(() {
        isLoaded = true;
      });
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: response,
        ),
      );
      return;
    }

    requestList = response.data['data'];

    setState(() {
      isLoaded = true;
    });
  }

  Future<void> searchRequests() async {
    setState(() {
      isSearching = true;
    });

    dynamic response = await _appService.browseRequests(
      searchKey: searchKeyString,
      priority: priority_key == "All" ? null : priority_key,
      service_id: service_key == null ? null : service_key['id'],
      city_id: selected_city == null ? null : selected_city['id'],
    );
    if (!mounted) return;

    if (response is String || response == null) {
      requestList = null;
      setState(() {
        isSearching = false;
      });
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: response,
        ),
      );
      return;
    }

    requestList = response.data['data'];

    setState(() {
      isSearching = false;
    });
  }

  Future<List<dynamic>> searchCityData(filter) async {
    final response = await _appService.locationAutoComplete(city: filter);
    if (response is String || response == null) {
      setState(() {});
    } else {
      setState(() {
        dynamic data = response.data['data'];
        cityList = [];
        for (int i = 0; i < data.length; i++) {
          cityList.add({
            'selected': false,
            'id': data[i]['city']['id'],
            'name': data[i]['city']['name']
          });
        }
      });
    }
    return cityList;
  }

  void showNow1(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
              backgroundColor:
                  context.watch<AppService>().themeState.isDarkTheme == false
                      ? Colors.white
                      : Color.fromARGB(221, 36, 36, 36),
              bottomNavigationBar: InkWell(
                  onTap: () async {
                    searchRequests();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(248, 248, 248, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      Languages.of(context)!.search,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(43, 44, 46, 1)),
                    ),
                  )),
              body: Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  decoration: BoxDecoration(
                    color: context.watch<AppService>().themeState.isDarkTheme ==
                            false
                        ? Colors.white
                        : Color.fromARGB(221, 36, 36, 36),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Languages.of(context)!.filters,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          Languages.of(context)!.selectCategory,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromARGB(221, 31, 31, 31)
                                  : Colors.white70),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        serviceList != null
                            ? DropdownSearch<dynamic>(
                                items: serviceList,
                                itemAsString: (item) => item['name'],
                                selectedItem: service_key,
                                onChanged: (dynamic value) {
                                  setState(() {
                                    service_key = value;
                                  });
                                },
                                clearButtonProps: ClearButtonProps(
                                    isVisible: true,
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white70,
                                    )),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                      fillColor: context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .isDarkTheme ==
                                              false
                                          ? Colors.white
                                          : Color.fromARGB(221, 19, 19, 19),
                                      filled: true,
                                      contentPadding: EdgeInsets.only(
                                          left: 10, right: 0, top: 12),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none),
                                ),
                                popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  fit: FlexFit.loose,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 20),
                        Text(
                          Languages.of(context)!.searchCity,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(0, 0, 0, 0.7)
                                  : Colors.white70),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownSearch<dynamic>(
                          asyncItems: (filter) => searchCityData(filter),
                          itemAsString: (item) => item['name'],
                          selectedItem: selected_city,
                          onChanged: (dynamic value) {
                            setState(() {
                              selected_city = value;
                            });
                          },
                          clearButtonProps: ClearButtonProps(
                              isVisible: true,
                              icon: Icon(
                                Icons.close,
                                color: Colors.white70,
                              )),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                fillColor: context
                                            .watch<AppService>()
                                            .themeState
                                            .isDarkTheme ==
                                        false
                                    ? Colors.white
                                    : Color.fromARGB(221, 19, 19, 19),
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    left: 10, right: 0, top: 12),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                          ),
                          popupProps: PopupProps.menu(
                            isFilterOnline: true,
                            showSearchBox: true,
                            fit: FlexFit.loose,
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          Languages.of(context)!.priority,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(0, 0, 0, 0.7)
                                  : Colors.white70),
                        ),
                        DropdownButton<String>(
                          value: priority_translated_key,
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          elevation: 8,
                          isExpanded: true,
                          alignment: AlignmentDirectional.center,
                          focusColor: Colors.white,
                          underline: Container(
                            color: Colors.white,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              priority_translated_key = value!;
                              for (int i = 0;
                                  i < priorityFilterList.length;
                                  i++) {
                                if (priority_translated_key ==
                                    priorityFilterList[i])
                                  priority_key = priorityList[i];
                              }
                            });
                          },
                          items: priorityFilterList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Divider(
                          height: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ]))));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              priorityFilterList = <String>[];
              priority_translated_key =
                  Languages.of(context)!.all.toUpperCase();
              priorityFilterList.add(Languages.of(context)!.all.toUpperCase());
              priorityFilterList.add(Languages.of(context)!.free.toUpperCase());
              priorityFilterList.add(Languages.of(context)!.high.toUpperCase());
              showNow1(context);
            });
          },
          backgroundColor:
              context.watch<AppService>().themeState.isDarkTheme == true
                  ? Color.fromRGBO(24, 24, 24, 1)
                  : Color(0xFF1B80C4),
          child: const Icon(
            Icons.tune,
            size: 30,
            color: Color.fromRGBO(214, 214, 214, 1),
          ),
        ),
        backgroundColor:
            context.watch<AppService>().themeState.isDarkTheme == false
                ? Colors.white
                : Color.fromRGBO(43, 44, 46, 1),
        appBar: PreferredSize(
          child: Container(
            height: 120,
            child: AppBar(
              toolbarHeight: 100,
              automaticallyImplyLeading: false,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: searchTextCtrl,
                    onChanged: (value) {
                      _appService.setKeywords(value);
                      setState(() {
                        searchKeyString = value;
                      });
                      searchRequests();
                    },
                    onFieldSubmitted: (value) {
                      _appService.setKeywords(value);
                      setState(() {
                        searchKeyString = value;
                      });
                      searchRequests();
                    },
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.always,
                    textInputAction: TextInputAction.none,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10),
                        vertical: getProportionateScreenHeight(19),
                      ),
                      hintText: Languages.of(context)!.searchCategory,
                      hintStyle: TextStyle(
                          color: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Color.fromRGBO(0, 0, 0, 0.5)
                              : Color.fromRGBO(255, 255, 255, 0.5)),
                      suffix: isSearching
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              height: 10,
                            ),
                      prefixIcon: Icon(Icons.search),
                      fillColor:
                          context.watch<AppService>().themeState.isDarkTheme ==
                                  false
                              ? Color.fromRGBO(242, 243, 245, 1)
                              : Color.fromRGBO(24, 24, 24, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(100),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              isLoaded
                  ? _appService.user['credits'] == 0
                      ? Center(
                          child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: context
                                              .watch<AppService>()
                                              .themeState
                                              .isDarkTheme ==
                                          false
                                      ? Color.fromARGB(255, 201, 199, 199)
                                      : Color.fromRGBO(57, 58, 60, 1)),
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
                                  '0 ' + Languages.of(context)!.credits,
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
                                  Languages.of(context)!
                                      .requireCreditsDescription,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(
                                      Languages.of(context)!.depositCoins,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  onTap: () {
                                    if (kIsWeb)
                                      GoRouter.of(context).pushNamed(
                                          APP_PAGE.buyCredits.toName);
                                    else if (Platform.isIOS)
                                      GoRouter.of(context).pushNamed(
                                          APP_PAGE.buyCreditsApple.toName);
                                    else
                                      GoRouter.of(context).pushNamed(
                                          APP_PAGE.buyCredits.toName);
                                  },
                                )
                              ])))
                      : requestList != null && requestList.length != 0
                          ? Flexible(
                              child: RefreshIndicator(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      controller: borwseScrollController,
                                      itemCount: requestList.length,
                                      physics: ScrollPhysics(),
                                      itemBuilder: (ctx, index) => InkWell(
                                          onTap: () {
                                            _appService.selectedJobData =
                                                requestList[index];
                                            _appService.isFromBrowser = true;
                                            if (_appService.user['credits'] ==
                                                0) {
                                              if (Platform.isIOS) {
                                                GoRouter.of(context).pushNamed(
                                                    APP_PAGE.buyCreditsApple
                                                        .toName);
                                              } else {
                                                GoRouter.of(context).pushNamed(
                                                    APP_PAGE.buyCredits.toName);
                                              }
                                            } else
                                              GoRouter.of(context).pushNamed(
                                                  APP_PAGE.jobDetails.toName);
                                            // GoRouter.of(context).pushNamed(
                                            //     APP_PAGE
                                            //         .directJobDetails.toName,
                                            //     params: {
                                            //       "requestID":
                                            //           requestList[index]['id']
                                            //               .toString()
                                            //     });
                                          },
                                          child: RequestItemCard(
                                              index: index,
                                              data: requestList[index]))),
                                  onRefresh: () async {
                                    refreshRequests();
                                  }))
                          : Center(
                              child: Column(children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Text(Languages.of(context)!.nojobreq,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 300,
                                  child: Text(
                                      Languages.of(context)!.nojobreq_des,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromRGBO(176, 176, 176, 1),
                                          fontWeight: FontWeight.w500)),
                                )
                              ]),
                            )
                  : Expanded(child: Center(child: CircularProgressIndicator())),
              if (isLoadMoreRequests)
                Container(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator())
            ],
          ),
        ));
  }
}
