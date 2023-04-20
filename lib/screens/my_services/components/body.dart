import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/constants.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/size_config.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  dynamic chatRooms;
  dynamic myCityList;
  dynamic serviceList = [];
  dynamic allServiceList = [];
  dynamic selectedServiceList = [];
  dynamic cityList = [];
  dynamic selectedCities = [];
  dynamic myServiceList = [];
  ScrollController serviceScrollController = ScrollController();
  final TextEditingController eCtrl = TextEditingController();
  final TextEditingController cityInputCtrl = TextEditingController();
  bool isLoadMoreService = false;
  String searchServiceKey = '';
  String searchCityKey = '';
  bool loadingCities = false;
  bool isAdding = false;
  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    serviceScrollController.addListener(() {
      if (serviceScrollController.position.pixels ==
          serviceScrollController.position.maxScrollExtent) {
        if (!isLoadMoreService) loadMoreService();
      }
    });
    getMyService();
    super.initState();
  }

  @override
  void dispose() {
    //...
    super.dispose();
    //...
  }

  Future<void> loadMoreService() async {
    setState(() {
      isLoadMoreService = true;
    });

    dynamic response =
        await _appService.getMyServices1(offset: myServiceList.length);

    if (response is String || response == null) {
      setState(() {
        isLoadMoreService = false;
      });
      return;
    } else {
      setState(() {
        isLoadMoreService = false;
        myServiceList.addAll(response.data['data']);
      });
    }
  }

  Future<void> getServiceList() async {
    final response = await _appService.getAllServices();
    setState(() {
      serviceList = [];
      allServiceList = [];
    });
    if (response is String || response == null) {
      setState(() {});
    } else {
      setState(() {
        dynamic data = response.data['data'];
        for (int i = 0; i < data.length; i++) {
          bool flag = false;
          for (int j = 0; j < myServiceList.length; j++) {
            if (data[i]['id'] == myServiceList[j]['service']['id']) {
              flag = true;
            }
          }

          serviceList.add({
            'name': data[i]['name'],
            "selected": flag,
            'id': data[i]['id'],
            "enabled": !flag
          });
          allServiceList.add({
            'name': data[i]['name'],
            "selected": flag,
            'id': data[i]['id'],
            "enabled": !flag
          });
        }
      });
      checkSelectedServies();
    }
  }

  Future<void> searchCities(String key) async {
    setState(() {
      cityList = [];
    });
    final response = await _appService.locationAutoComplete(city: key);
    if (response is String || response == null) {
      setState(() {});
    } else {
      setState(() {
        dynamic data = response.data['data'];
        for (int i = 0; i < data.length; i++) {
          cityList.add({
            'selected': false,
            'id': data[i]['city']['id'],
            'name': data[i]['city']['name'] + ', ' + data[i]['city']['region']
          });
          for (int j = 0; j < selectedCities.length; j++) {
            if (selectedCities[j]['id'] == data[i]['city']['id'])
              cityList[i]['selected'] = true;
          }
        }
      });
    }
  }

  Future<void> searchServiceList(String key) async {
    serviceList = [];
    for (int i = 0; i < allServiceList.length; i++) {
      if (removeDiacritics(allServiceList[i]['name'])
          .toLowerCase()
          .contains(key.toLowerCase()))
        setState(() {
          serviceList.add({
            'name': allServiceList[i]['name'],
            "selected": false,
            'id': allServiceList[i]['id']
          });
        });
      // if (allServiceList[i]['name']
      //     .toString()
      //     .toLowerCase()
      //     .contains(key.toLowerCase()))
      //   setState(() {
      //     serviceList.add({
      //       'name': allServiceList[i]['name'],
      //       "selected": false,
      //       'id': allServiceList[i]['id']
      //     });
      //   });
    }
    checkSelectedServies();
  }

  Future<void> checkSelectedServies() async {
    if (selectedServiceList.length == 0) return;
    if (serviceList.length == 0) return;
    for (int i = 0; i < selectedServiceList.length; i++) {
      for (int j = 0; j < serviceList.length; j++) {
        if (selectedServiceList[i]['id'] == serviceList[j]['id']) {
          setState(() {
            serviceList[j]['selected'] = true;
          });
        }
      }
    }
  }

  Future<void> getMyService() async {
    dynamic response = await _appService.getMyServices1();

    if (response is String || response == null) {
      myServiceList = [];
    } else {
      myServiceList = response.data['data'];
    }
    await getServiceList();

    setState(() {
      isLoaded = true;
    });
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
            : myServiceList == null || myServiceList?.length == 0
                ? Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Image.asset(
                          'assets/images/no_service.png',
                          fit: BoxFit.cover,
                          width: 100,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        Languages.of(context)!.noService,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        Languages.of(context)!.noServicesDesc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(176, 176, 176, 1)),
                      ),
                    ],
                  ))
                : Column(
                    children: [
                      SizedBox(height: 15),
                      Flexible(
                          child: RefreshIndicator(
                              child: ListView.builder(
                                  itemCount: myServiceList.length,
                                  shrinkWrap: true,
                                  controller: serviceScrollController,
                                  physics: ScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Dismissible(
                                        key: ValueKey<dynamic>(
                                            myServiceList[index]),
                                        background: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5.5),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  232, 104, 112, 1),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              children: [
                                                RotatedBox(
                                                    quarterTurns: 3,
                                                    child: Text(
                                                      Languages.of(context)!
                                                          .delete_btn
                                                          .toUpperCase(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                                Expanded(child: Container()),
                                                RotatedBox(
                                                    quarterTurns: 1,
                                                    child: Text(
                                                      Languages.of(context)!
                                                          .delete_btn
                                                          .toUpperCase(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                              ],
                                            )),
                                        onDismissed:
                                            (DismissDirection direction) async {
                                          await _appService.deleteMyServiceID(
                                              id: myServiceList[index]['id']);
                                          setState(() {
                                            myServiceList.removeAt(index);
                                          });
                                          await getMyService();
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 17, vertical: 15),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5.5),
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  181, 228, 202, 1),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.card_travel,
                                                      size: 20,
                                                      color: Color.fromRGBO(
                                                          43, 44, 46, 1)),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    myServiceList[index]
                                                        ['service']['name'],
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            43, 44, 46, 1)),
                                                  ),
                                                  Expanded(child: Container()),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 20,
                                                      color: Color.fromRGBO(
                                                          43, 44, 46, 1)),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    myServiceList[index]['city']
                                                        ['name'],
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            43, 44, 46, 1)),
                                                  ),
                                                  Expanded(child: Container()),
                                                ],
                                              ),
                                            ])));
                                  }),
                              onRefresh: () async {
                                getMyService();
                              })),
                      isLoadMoreService
                          ? CircularProgressIndicator()
                          : Container(),
                    ],
                  ));
  }

  void showAddCityScreen(BuildContext context) {
    dynamic cityListData = [];
    setState(() {
      isAdding = false;
      selectedCities = [];
      searchCityKey = '';
      cityList = [];
      cityInputCtrl.text = "";
    });
    showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Scaffold(
              bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                            showAddServiceScreen(
                              context,
                            );
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(248, 248, 248, 1)
                                  : context
                                          .watch<AppService>()
                                          .themeState
                                          .customColors[
                                      AppColors.secondaryButtonColor],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              Languages.of(context)!.backButton,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: context
                                              .watch<AppService>()
                                              .themeState
                                              .isDarkTheme ==
                                          false
                                      ? Color.fromRGBO(43, 44, 46, 1)
                                      : context
                                              .watch<AppService>()
                                              .themeState
                                              .customColors[
                                          AppColors.secondaryButtonTextColor]),
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      isAdding
                          ? Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            )
                          : InkWell(
                              onTap: () async {
                                setState(() {
                                  isAdding = true;
                                });
                                dynamic response =
                                    await _appService.addMyService1(
                                        service_id: _appService
                                            .selectedServiceToAdd['id'],
                                        city_id: selectedCities[0]['id']);
                                setState(() {
                                  isAdding = false;
                                });
                                if (response is String || response == null) {
                                  showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                        message: response,
                                      ));
                                } else {
                                  showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.success(
                                        message:
                                            Languages.of(context)!.addSucceed,
                                      ));
                                }
                                await getMyService();
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: context
                                              .watch<AppService>()
                                              .themeState
                                              .isDarkTheme ==
                                          false
                                      ? Color.fromRGBO(248, 248, 248, 1)
                                      : context
                                              .watch<AppService>()
                                              .themeState
                                              .customColors[
                                          AppColors.secondaryButtonColor],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  Languages.of(context)!.addButton,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .isDarkTheme ==
                                              false
                                          ? Color.fromRGBO(43, 44, 46, 1)
                                          : context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .customColors[
                                              AppColors
                                                  .secondaryButtonTextColor]),
                                ),
                              )),
                    ],
                  )),
              backgroundColor:
                  context.watch<AppService>().themeState.isDarkTheme == false
                      ? Colors.white
                      : Colors.black,
              body: Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          Languages.of(context)!.addCity,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(43, 44, 46, 1)
                                  : Colors.white70),
                        )),
                    SizedBox(
                      height: 19,
                    ),
                    Text(
                      Languages.of(context)!.searchCity,
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
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 11),
                      child: TextFormField(
                        controller: cityInputCtrl,
                        onChanged: (value) async {
                          if (value.toString().length > 2) {
                            setState(() {
                              loadingCities = true;
                            });
                            await searchCities(value);
                            setState(() {
                              loadingCities = false;
                            });
                            setState(() {
                              searchCityKey = value;
                              loadingCities = false;

                              cityListData = cityList;
                            });
                          } else {
                            searchCityKey = value;
                            cityListData = [];
                          }
                        },
                        onFieldSubmitted: (value) async {
                          if (value.toString().length > 2) {
                            setState(() {
                              loadingCities = true;
                            });
                            await searchCities(value);
                            setState(() {
                              loadingCities = false;
                            });
                            setState(() {
                              searchCityKey = value;
                              cityListData = cityList;
                            });
                          } else {
                            searchCityKey = value;
                            cityListData = [];
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 1.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Color.fromRGBO(242, 243, 245, 1)
                              : Colors.black87,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10),
                            vertical: getProportionateScreenHeight(19),
                          ),
                          hintText: Languages.of(context)!.search_city,
                          prefixIcon: Icon(Icons.search),
                          suffix: loadingCities
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator())
                              : Container(
                                  width: 10,
                                  height: 10,
                                ),
                        ),
                      ),
                    ),
                    cityListData.length == 0
                        ? Container(
                            height: 50,
                            child: Text(
                              selectedCities.length == 0
                                  ? Languages.of(context)!.noCity
                                  : selectedCities.length.toString() +
                                      Languages.of(context)!.selectedCities,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ))
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cityListData.length,
                              itemBuilder: (ctx, index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                    color: context
                                                .watch<AppService>()
                                                .themeState
                                                .isDarkTheme ==
                                            false
                                        ? Colors.transparent
                                        : Colors.black87,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        color: context
                                                    .watch<AppService>()
                                                    .themeState
                                                    .isDarkTheme ==
                                                false
                                            ? Color.fromRGBO(218, 218, 218, 1)
                                            : Colors.black87)),
                                child: CheckboxListTile(
                                  title: Text(
                                      cityListData[index]['name'].toString()),
                                  value: cityListData[index]['selected'],
                                  onChanged: (newValue) {
                                    setState(() => {
                                          cityListData[index]['selected'] =
                                              !cityListData[index]['selected'],
                                          for (int i = 0;
                                              i < cityListData.length;
                                              i++)
                                            if (i != index)
                                              cityListData[i]['selected'] =
                                                  false,
                                          if (newValue == true)
                                            {
                                              selectedCities
                                                  .add(cityListData[index]),
                                              selectedCities.removeWhere(
                                                  (item) =>
                                                      item['id'] !=
                                                      cityListData[index]
                                                          ['id']),
                                            }
                                          else
                                            selectedCities.removeWhere((item) =>
                                                item['id'] ==
                                                cityListData[index]['id']),
                                        });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  dense: true,
                                  checkColor: Color.fromRGBO(67, 160, 71, 1),
                                  activeColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void showAddServiceScreen(BuildContext context) {
    setState(() {
      selectedServiceList = [];
      serviceList = allServiceList;
      searchServiceKey = '';
      eCtrl.text = "";
      for (int i = 0; i < serviceList.length; i++) {
        serviceList[i]['selected'] = false;
      }
    });
    showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async {
                            setState(() {
                              selectedServiceList = [];
                            });

                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(248, 248, 248, 1)
                                  : context
                                          .watch<AppService>()
                                          .themeState
                                          .customColors[
                                      AppColors.secondaryButtonColor],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              Languages.of(context)!.backButton,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: context
                                              .watch<AppService>()
                                              .themeState
                                              .isDarkTheme ==
                                          false
                                      ? Color.fromRGBO(43, 44, 46, 1)
                                      : context
                                              .watch<AppService>()
                                              .themeState
                                              .customColors[
                                          AppColors.secondaryButtonTextColor]),
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          onTap: () async {
                            if (selectedServiceList.length != 0) {
                              Navigator.pop(context);
                              showAddCityScreen(
                                context,
                              );
                            } else {
                              showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: Languages.of(context)!.noService,
                                  ));
                            }
                          },
                          child: Container(
                            width: 180,
                            decoration: BoxDecoration(
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(248, 248, 248, 1)
                                  : context
                                          .watch<AppService>()
                                          .themeState
                                          .customColors[
                                      AppColors.secondaryButtonColor],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              Languages.of(context)!.addCity,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: context
                                              .watch<AppService>()
                                              .themeState
                                              .isDarkTheme ==
                                          false
                                      ? Color.fromRGBO(43, 44, 46, 1)
                                      : context
                                              .watch<AppService>()
                                              .themeState
                                              .customColors[
                                          AppColors.secondaryButtonTextColor]),
                            ),
                          )),
                    ],
                  )),
              backgroundColor:
                  context.watch<AppService>().themeState.isDarkTheme == false
                      ? Colors.white
                      : Colors.black,
              body: Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          Languages.of(context)!.addService,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(43, 44, 46, 1)
                                  : Colors.white70),
                        )),
                    SizedBox(
                      height: 19,
                    ),
                    Text(
                      Languages.of(context)!.searchService,
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
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 11),
                      child: TextFormField(
                        controller: eCtrl,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              serviceList = allServiceList;
                            });
                          }
                          setState(() {
                            searchServiceKey = value;
                            searchServiceList(searchServiceKey);
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 1.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Color.fromRGBO(242, 243, 245, 1)
                              : Colors.black87,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(1),
                            vertical: getProportionateScreenHeight(19),
                          ),
                          hintText: Languages.of(context)!.searchCategory,
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    serviceList.length == 0
                        ? Container(
                            height: 50,
                            child: Text(
                              selectedServiceList.length == 0
                                  ? Languages.of(context)!.noService
                                  : selectedServiceList.length.toString() +
                                      Languages.of(context)!.selectedServices,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ))
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: serviceList.length,
                              itemBuilder: (ctx, index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: context
                                                .watch<AppService>()
                                                .themeState
                                                .isDarkTheme ==
                                            false
                                        ? Colors.transparent
                                        : Colors.black87,
                                    border: Border.all(
                                        color: context
                                                    .watch<AppService>()
                                                    .themeState
                                                    .isDarkTheme ==
                                                false
                                            ? Color.fromRGBO(218, 218, 218, 1)
                                            : Colors.black87)),
                                child: CheckboxListTile(
                                  title: Text(
                                      serviceList[index]['name'].toString()),
                                  value: serviceList[index]['selected'],
                                  onChanged: (newValue) {
                                    setState(() => {
                                          serviceList[index]['selected'] =
                                              !serviceList[index]['selected'],
                                          if (newValue == true)
                                            selectedServiceList
                                                .add(serviceList[index])
                                          else
                                            selectedServiceList.removeWhere(
                                                (item) =>
                                                    item['id'] ==
                                                    serviceList[index]['id']),
                                          eCtrl.text = "",
                                        });
                                    if (newValue == true) {
                                      _appService.selectedServiceToAdd =
                                          serviceList[index];
                                      for (int i = 0;
                                          i < serviceList.length;
                                          i++) {
                                        if (i != index &&
                                            serviceList[i]['enabled'] == true)
                                          serviceList[i]['selected'] = false;
                                      }
                                    }
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  enabled: serviceList[index]['enabled'],
                                  dense: true,
                                  checkColor: Color.fromRGBO(67, 160, 71, 1),
                                  activeColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: (() => GoRouter.of(context).pop())),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
              icon: Icon(
                Icons.add_box_rounded,
                size: 25,
                color:
                    context.watch<AppService>().themeState.isDarkTheme == false
                        ? Colors.black
                        : Colors.white,
              ),
              onPressed: (() async {
                showAddServiceScreen(context);
              })),
        )
      ],
      title: Column(
        children: [
          Text(
            Languages.of(context)!.myServices,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
