import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/localization/locale_constant.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:skeletons/skeletons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  late int selected_country = 0;
  late final SharedPreferences sharedPreferences;
  bool isLoaded = false;
  dynamic countryList;

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    getCountries();
  }

  Future<void> getCountries() async {
    dynamic response = await _appService.getCountryList();
    if (!mounted) return;

    if (response is String || response == null) {
      countryList = null;
      setState(() {
        isLoaded = true;
      });
      return;
    }
    setState(
      () {
        countryList = response.data;
      },
    );
    setState(() {
      isLoaded = true;
    });
    _appService.countryList = countryList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context
          .watch<AppService>()
          .themeState
          .customColors[AppColors.primaryBackgroundColor],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  child: Text(
                    Languages.of(context)!.countryHeading,
                    style: TextStyle(
                        color: context
                            .watch<AppService>()
                            .themeState
                            .customColors[AppColors.primaryTextColor1],
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  )),
              SizedBox(
                height: 35,
              ),
              !isLoaded
                  ? SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 6,
                          spacing: 8,
                          lineStyle: SkeletonLineStyle(
                            randomLength: false,
                            height: 45,
                            width: double.infinity,
                          )),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: countryList.length,
                      itemBuilder: (ctx, index) => InkWell(
                            onTap: () async {
                              setState(() {
                                selected_country = index;
                              });
                            },
                            child: Container(
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(242, 243, 245, 1)
                                  : Colors.black87,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 13),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    alignment: Alignment.bottomCenter,
                                    child: selected_country != index
                                        ? Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color.fromRGBO(
                                                        224, 224, 224, 1)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          )
                                        : Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    79, 162, 219, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      43, 43, 43, 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    width: 28,
                                  ),
                                  Expanded(
                                      child: Text(
                                    countryList[index]['name'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: context
                                                .watch<AppService>()
                                                .themeState
                                                .customColors[
                                            AppColors.primaryTextColor1],
                                        fontWeight: FontWeight.w600),
                                  )),
                                ],
                              ),
                            ),
                          )),
            ],
          ),
        ),
      )),
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(10),
          width: 300,
          child: DefaultButton(
              text: Languages.of(context)!.start,
              press: () async {
                changeLanguage(
                    context, countryList[selected_country]['default_language']);
                await _appService.registerCountry(
                    countryList[selected_country]['default_language']);

                GoRouter.of(context)
                    .pushReplacementNamed(APP_PAGE.signIn.toName);
              })),
    );
  }
}
