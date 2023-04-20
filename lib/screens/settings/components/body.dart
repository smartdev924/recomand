import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/components/custom_bottom_navigation_bar.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/localization/locale_constant.dart';
import 'package:localservice/models/language_data.dart';
import 'package:localservice/cubit/theme_module/provider/theme_cubit.dart';
import 'package:localservice/cubit/theme_module/states/change_theme_states.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  LanguageData selectedLanguage = LanguageData.languageList().first;
  bool userType = false;
  late AppService _appService;
  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    if (_appService.user['user_type'] == "work") userType = true;
    setLanguage();
    super.initState();
  }

  Future<void> setLanguage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = await _prefs.getString("SelectedLanguageCode") ?? "";
    for (LanguageData supportedLocale in LanguageData.languageList()) {
      if (supportedLocale.languageCode == languageCode) {
        setState(() {
          selectedLanguage = supportedLocale;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
        bloc: changeThemeCubit,
        builder: (context, themeState) {
          return Scaffold(
            backgroundColor:
                themeState.customColors[AppColors.primaryBackgroundColor],
            bottomNavigationBar: userType
                ? CustomBottomNavigationBar(
                    selectedMenu: Menu.profile,
                    userType: true,
                  )
                : CustomBottomNavigationBar(
                    selectedMenu: Menu.profile,
                    userType: false,
                  ),
            body: _appService.user == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(224, 224, 224, 1)),
                          ),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/language.png',
                                fit: BoxFit.cover,
                                width: 24,
                                color: themeState.isDarkTheme == true
                                    ? Colors.white
                                    : Colors.black
                                // height: double.infinity,
                                ),
                            SizedBox(
                              width: 18,
                            ),
                            Text(
                              Languages.of(context)!.labelLanguage,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(child: Container()),
                            SizedBox(
                                width: 170,
                                child: _createLanguageDropDown(context)),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            final darkTheme = themeState.isDarkTheme;
                            if (darkTheme == true)
                              changeThemeCubit.changeToLightTheme();
                            else
                              changeThemeCubit.changeToDarkTheme();
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 18, bottom: 18),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: Color.fromRGBO(224, 224, 224, 1)),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                !themeState.isDarkTheme!
                                    ? const Icon(Icons.brightness_2)
                                    : const Icon(Icons.sunny),
                                SizedBox(
                                  width: 18,
                                ),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      Languages.of(context)!.lab_colorstyle,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Expanded(
                                    flex: 1, child: Icon(Icons.chevron_right)),
                              ],
                            ),
                          )),
                      // if (_appService.user['is_worker'])
                      //   InkWell(
                      //       onTap: () async {},
                      //       child: Container(
                      //         padding: EdgeInsets.only(top: 18, bottom: 18),
                      //         decoration: BoxDecoration(
                      //           border: Border(
                      //             bottom: BorderSide(
                      //                 width: 1.0,
                      //                 color: Color.fromRGBO(224, 224, 224, 1)),
                      //           ),
                      //           color: Colors.transparent,
                      //         ),
                      //         child: Row(
                      //           children: [
                      //             const Icon(Icons.account_box),
                      //             SizedBox(
                      //               width: 18,
                      //             ),
                      //             Expanded(
                      //                 flex: 5,
                      //                 child: Text(
                      //                   _appService.user['user_type'] == "hire"
                      //                       ? Languages.of(context)!.hireType
                      //                       : Languages.of(context)!.workType,
                      //                   style: TextStyle(
                      //                       fontSize: 15,
                      //                       fontWeight: FontWeight.w500),
                      //                 )),
                      //             Expanded(
                      //                 flex: 1,
                      //                 child: Switch(
                      //                   value: userType,
                      //                   activeColor: Colors.blueAccent,
                      //                   onChanged: (bool value) async {
                      //                     String type = 'hire';
                      //                     if (_appService.user['user_type'] ==
                      //                         "hire") type = 'work';
                      //                     dynamic response = await _appService
                      //                         .changeUserType(type: type);
                      //                     if (response is String ||
                      //                         response == null)
                      //                       showTopSnackBar(
                      //                         Overlay.of(context),
                      //                         CustomSnackBar.error(
                      //                           message: response,
                      //                         ),
                      //                       );
                      //                     else if (response.data['success'] ==
                      //                         false)
                      //                       showTopSnackBar(
                      //                         Overlay.of(context),
                      //                         CustomSnackBar.error(
                      //                           message:
                      //                               response.data['message'],
                      //                         ),
                      //                       );
                      //                     else {
                      //                       setState(() {
                      //                         userType = !userType;
                      //                       });
                      //                       GoRouter.of(context).pop();
                      //                       GoRouter.of(context).pushNamed(
                      //                           APP_PAGE.settings.toName);
                      //                     }
                      //                   },
                      //                 )),
                      //           ],
                      //         ),
                      //       )),
                      InkWell(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(APP_PAGE.changePassword.toName);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 18, bottom: 18),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: Color.fromRGBO(224, 224, 224, 1)),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.password_rounded),
                                SizedBox(
                                  width: 18,
                                ),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      Languages.of(context)!.lab_changepassword,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Expanded(
                                    flex: 1, child: Icon(Icons.chevron_right)),
                              ],
                            ),
                          )),
                      InkWell(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 18, bottom: 18),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: Color.fromRGBO(224, 224, 224, 1)),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/delete_account.png',
                                  fit: BoxFit.cover,
                                  width: 24,
                                  // height: double.infinity,
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      Languages.of(context)!.delete_account,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromRGBO(232, 104, 111, 1)),
                                    )),
                                Expanded(
                                    flex: 1, child: Icon(Icons.chevron_right)),
                              ],
                            ),
                          )),
                      InkWell(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(APP_PAGE.signIn.toName);
                            _appService.logOut();
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 18, bottom: 18),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: Color.fromRGBO(224, 224, 224, 1)),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Image.asset('assets/images/logout.png',
                                    fit: BoxFit.cover,
                                    width: 24,
                                    color: themeState.isDarkTheme == true
                                        ? Colors.white
                                        : Colors.black),
                                SizedBox(
                                  width: 18,
                                ),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      Languages.of(context)!.signout,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Expanded(
                                    flex: 1, child: Icon(Icons.chevron_right)),
                              ],
                            ),
                          )),
                    ]),
                  ),
          );
        });
  }

  showAlertDialog(
    BuildContext context,
  ) {
    final _appService = Provider.of<AppService>(context, listen: false);
    late TextEditingController _textEditingController = TextEditingController();
    Widget cancelButton = TextButton(
      child: Text(Languages.of(context)!.cancel_btn),
      onPressed: () {
        Navigator.pop(context, 'Cancel');
      },
    );
    Widget continueButton = TextButton(
      child: Text(Languages.of(context)!.delete_btn),
      onPressed: () async {
        if (_textEditingController.text == "") {
          return;
        } else {
          dynamic response = await _appService.closeAccount(
              password: _textEditingController.text);
          if (response is String || response == null)
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: response,
              ),
            );
          else
            GoRouter.of(context).pushNamed(APP_PAGE.signIn.toName);
          Navigator.pop(context, 'Ok');
        }
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Languages.of(context)!.areyousure),
      content: TextField(
        onChanged: (value) {},
        obscureText: true,
        controller: _textEditingController,
        decoration: InputDecoration(hintText: "Enter Password"),
      ),
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

  _createLanguageDropDown(context) {
    final _appService = Provider.of<AppService>(context, listen: false);

    return DropdownButton<LanguageData>(
      iconSize: 30,
      // value: selectedLanguage,
      hint: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          selectedLanguage.languageCode == "en"
              ? SvgPicture.asset(
                  'icons/flags/svg/us.svg',
                  package: 'country_icons',
                  width: 30,
                )
              : SvgPicture.asset(
                  'icons/flags/svg/' + selectedLanguage.languageCode + '.svg',
                  package: 'country_icons',
                  width: 30,
                ),
          SizedBox(
            width: 15,
          ),
          Text(selectedLanguage.name)
        ],
      ),
      onChanged: (LanguageData? language) async {
        setState(() {
          selectedLanguage = language!;
        });
        changeLanguage(context, language!.languageCode);
        dynamic response =
            await _appService.setLanguage(langCode: language.languageCode);
        if (response is String || response == null) {}
      },
      items: LanguageData.languageList()
          .map<DropdownMenuItem<LanguageData>>(
            (e) => DropdownMenuItem<LanguageData>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    'icons/flags/svg/' +
                        (e.languageCode == "en" ? "us" : e.languageCode) +
                        '.svg',
                    package: 'country_icons',
                    width: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(e.name)
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
