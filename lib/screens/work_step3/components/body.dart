import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../size_config.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController eCtrl = TextEditingController();
  dynamic cityList = [];
  dynamic selectedCities = [];
  late AppService _appService;
  bool loadingCities = false;

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    _appService.selectedSubServiceList = [];
    super.initState();
  }

  Future<void> searchCities(String key) async {
    setState(() {
      loadingCities = true;
    });
    final response = await _appService.locationAutoComplete(city: key);
    setState(() {
      loadingCities = false;
    });
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
            'name': data[i]['city']['name'] + ', ' + data[i]['city']['region']
          });
          for (int j = 0; j < selectedCities.length; j++) {
            if (selectedCities[j]['id'] == data[i]['city']['id'])
              cityList[i]['selected'] = true;
          }
        }
      });
      checkSelectedCities();
    }
  }

  Future<void> checkSelectedCities() async {
    if (selectedCities.length == 0) return;
    if (cityList.length == 0) return;
    for (int i = 0; i < selectedCities.length; i++) {
      for (int j = 0; j < cityList.length; j++) {
        if (selectedCities[i]['id'] == cityList[j]['id']) {
          setState(() {
            cityList[j]['selected'] = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.watch<AppService>().themeState.isDarkTheme == false
              ? Colors.white
              : context
                  .watch<AppService>()
                  .themeState
                  .customColors[AppColors.primaryBackgroundColor],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, top: 10),
              width: 330,
              child: Text(
                Languages.of(context)!.step3_heading,
                style: TextStyle(
                  fontSize: 32,
                  color: context
                      .watch<AppService>()
                      .themeState
                      .customColors[AppColors.primaryTextColor1],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, top: 10),
              width: 330,
              child: Text(
                _appService.selectedServiceToAdd['name'] == null
                    ? ""
                    : _appService.selectedServiceToAdd['name'] + '?',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(79, 162, 219, 1)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 15),
              width: 270,
              child: Text(
                Languages.of(context)!.change_anytime,
                style: TextStyle(
                  fontSize: 14,
                  color: context
                      .watch<AppService>()
                      .themeState
                      .customColors[AppColors.primaryTextColor1],
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              margin: EdgeInsets.only(bottom: 11),
              child: TextFormField(
                controller: eCtrl,
                onFieldSubmitted: (value) {
                  if (value.toString().length > 2) searchCities(value);
                  if (value.toString().length < 3)
                    setState(() {
                      cityList = [];
                    });
                },
                onChanged: (value) {
                  if (value.toString().length > 2) searchCities(value);
                  if (value.toString().length < 3)
                    setState(() {
                      cityList = [];
                    });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor:
                        context.watch<AppService>().themeState.isDarkTheme ==
                                false
                            ? Color.fromRGBO(242, 243, 245, 1)
                            : Color.fromRGBO(13, 13, 13, 1),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15),
                      vertical: getProportionateScreenHeight(19),
                    ),
                    hintText: Languages.of(context)!.search_city,
                    prefixIcon: Icon(Icons.search),
                    suffix: loadingCities
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            height: 10,
                          )),
              ),
            ),
            cityList.length != 0
                ? Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cityList.length,
                      itemBuilder: (ctx, index) => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: context
                                        .watch<AppService>()
                                        .themeState
                                        .isDarkTheme ==
                                    false
                                ? Colors.white
                                : Color.fromRGBO(13, 13, 13, 1),
                            border: Border.all(
                                color: context
                                            .watch<AppService>()
                                            .themeState
                                            .isDarkTheme ==
                                        false
                                    ? Color.fromRGBO(218, 218, 218, 1)
                                    : Color.fromRGBO(13, 13, 13, 1))),
                        child: CheckboxListTile(
                          title: Text(
                            cityList[index]['name'],
                            style: TextStyle(
                                color: context
                                    .watch<AppService>()
                                    .themeState
                                    .customColors[AppColors.primaryTextColor1]),
                          ),
                          value: cityList[index]['selected'],
                          onChanged: (newValue) {
                            setState(() {
                              cityList[index]['selected'] =
                                  !cityList[index]['selected'];
                              if (newValue == true) {
                                selectedCities = [];
                                selectedCities.add(cityList[index]);
                              } else {
                                selectedCities.removeWhere((item) =>
                                    item['id'] == cityList[index]['id']);
                              }
                            });
                            setState(() {
                              cityList = [];
                              eCtrl.text = '';
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                          checkColor: Color.fromRGBO(79, 162, 219, 1),
                          activeColor: Colors.transparent,
                        ),
                      ),
                    ),
                    height: 200,
                  )
                : Container(
                    child: Text(
                      eCtrl.text.length > 2
                          ? Languages.of(context)!.noSearchResult
                          : Languages.of(context)!.inputThree,
                      style: TextStyle(
                        fontSize: 16,
                        color: context
                            .watch<AppService>()
                            .themeState
                            .customColors[AppColors.primaryTextColor1],
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 13),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                Languages.of(context)!.selected_city,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: context
                      .watch<AppService>()
                      .themeState
                      .customColors[AppColors.primaryTextColor1],
                  height: 1.5,
                ),
              ),
            ),
            if (selectedCities.length != 0)
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: selectedCities.length,
                  itemBuilder: (ctx, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                false
                            ? Colors.white
                            : Color.fromRGBO(13, 13, 13, 1),
                        border: Border.all(
                            color: context
                                        .watch<AppService>()
                                        .themeState
                                        .isDarkTheme ==
                                    false
                                ? Color.fromRGBO(218, 218, 218, 1)
                                : Color.fromRGBO(13, 13, 13, 1))),
                    child: CheckboxListTile(
                      title: Text(
                        selectedCities[index]['name'],
                        style: TextStyle(
                            color: context
                                .watch<AppService>()
                                .themeState
                                .customColors[AppColors.primaryTextColor1]),
                      ),
                      value: selectedCities[index]['selected'],
                      onChanged: (newValue) {
                        if (newValue == false) {
                          setState(
                            () {
                              for (int i = 0; i < cityList.length; i++) {
                                if (cityList[i]['id'] ==
                                    selectedCities[index]['id'])
                                  setState(() {
                                    cityList[i]['selected'] = false;
                                  });
                              }
                              selectedCities.removeAt(index);
                            },
                          );
                        }
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      checkColor: Color.fromRGBO(79, 162, 219, 1),
                      activeColor: Colors.transparent,
                    ),
                  ),
                ),
                height: 200,
              ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: DefaultButton(
              text: Languages.of(context)!.addBtn,
              press: () async {
                if (selectedCities.length == 0) {
                  showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.info(
                        message: Languages.of(context)!.alert_city,
                      ));
                  return;
                }
                dynamic response = await _appService.addMyService1(
                    city_id: selectedCities[0]['id'],
                    service_id: _appService.selectedServiceToAdd['id']);
                if (response is String || response == null) {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message: response,
                    ),
                  );
                } else {
                  if (response.data['success'])
                    GoRouter.of(context)
                        .pushNamed(APP_PAGE.becomeSeller.toName);
                  else
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: response.data['message'],
                      ),
                    );
                }
              })),
    );
  }
}
