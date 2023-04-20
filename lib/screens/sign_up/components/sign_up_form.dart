// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/app_state_listener.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/gray_button.dart';
import 'package:geolocator/geolocator.dart';

enum SigningCharacter { WORK, HIRE }

class SignUpForm extends StatefulWidget {
  final String? codeInvited;
  SignUpForm({this.codeInvited});
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String email, password, confirmPassword, name = "", inviteCode = '';
  String latitude = '', longitude = '';
  final List<String> errors = [];
  bool firstSubmit = false;
  bool isLoaded = false;
  bool remember = false;
  late AppService appService;
  AppStateListener _appStateListener = AppStateListener();
  bool isCreating = false;
  bool isHide = true;
  bool hasCode = false;
  bool isEmail = false;

  String? deviceID;
  String? mToken;

  SigningCharacter? _character = SigningCharacter.WORK;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    appService = Provider.of<AppService>(context, listen: false);
    WidgetsBinding.instance.addObserver(_appStateListener);
    getCode();
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        _determinePosition();
        getToken();
      }
    }
    getDeviceID();
    super.initState();
  }

  Future<void> getCode() async {
    if (appService.inviteCode != '') {
      this.inviteCode = appService.inviteCode;
      appService.inviteCode = '';
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isLoaded = true;
      }); // Prints after 1 second.
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appStateListener);
    super.dispose();
  }

  void getDeviceID() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = '';
    }
    setState(() {
      deviceID = deviceId!;
    });
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      latitude = 'Location services';
      longitude = 'are disabled';
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        latitude = 'Permission';
        longitude = 'denied';
        return;
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      latitude = 'Permission';
      longitude = 'permanently denied';
      return;
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position _position = await Geolocator.getCurrentPosition();
    setState(() {
      longitude = _position == null ? 'null' : _position.longitude.toString();
      latitude = _position == null ? 'null' : _position.latitude.toString();
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mToken = token!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_appStateListener.isInForeground && appService.inviteCode != '') {
      setState(() {
        isLoaded = false;
      });
      getCode();
    }
    return !isLoaded
        ? SizedBox()
        : Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNameFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  onSaved: (newEmail) => this.email = newEmail!,
                  onChanged: (email) {
                    if (email.isEmpty) {
                      setState(() {
                        isEmail = false;
                      });
                    } else if (email.isNotEmpty &&
                        !emailValidatorRegExp.hasMatch(email)) {
                      setState(() {
                        isEmail = false;
                      });
                    } else {
                      setState(() {
                        isEmail = true;
                      });
                    }
                    if (firstSubmit) _formKey.currentState!.validate();
                  },
                  validator: (email) {
                    if (email!.isEmpty) {
                      return Languages.of(context)!.kEmailNullError;
                    } else if (email.isNotEmpty &&
                        !emailValidatorRegExp.hasMatch(email)) {
                      return Languages.of(context)!.kInvalidEmailError;
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: Languages.of(context)!.email,
                      hintText: Languages.of(context)!.pleaseendteryouremail,
                      suffixIcon: Icon(
                        isEmail ? Icons.check : Icons.email_rounded,
                      )),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  onSaved: (newPassword) => this.password = newPassword!,
                  onChanged: (password) {
                    if (firstSubmit) _formKey.currentState!.validate();
                    this.password = password;
                  },
                  validator: (password) {
                    if (password!.isEmpty) {
                      return Languages.of(context)!.kPassNullError;
                    } else if (password.isNotEmpty && password.length <= 7) {
                      return Languages.of(context)!.kShortPassError;
                    }

                    return null;
                  },
                  obscureText: isHide,
                  decoration: InputDecoration(
                    labelText: Languages.of(context)!.password,
                    hintText: Languages.of(context)!.pleaseenteryourpassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isHide = !isHide;
                        });
                      },
                      icon: Icon(
                        isHide ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  onSaved: (newPassword) => this.confirmPassword = newPassword!,
                  onChanged: (password) {
                    if (firstSubmit) _formKey.currentState!.validate();
                    this.confirmPassword = password;
                  },
                  validator: (password) {
                    if (password!.isEmpty) {
                      return Languages.of(context)!.kPassNullError;
                    } else if (password != this.password) {
                      return Languages.of(context)!.kConfirmPasswordError;
                    }

                    return null;
                  },
                  obscureText: isHide,
                  decoration: InputDecoration(
                    labelText: Languages.of(context)!.confirmnewpassword,
                    hintText: Languages.of(context)!.pleaseenteryourpassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isHide = !isHide;
                        });
                      },
                      icon: Icon(
                        isHide ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildInviteFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  Languages.of(context)!.iWant,
                  style: TextStyle(
                    color: Color.fromRGBO(94, 94, 94, 1),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Container(
                    // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4) a@a.com,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Color.fromRGBO(218, 218, 218, 1))),
                    child: Row(
                      children: [
                        Flexible(
                            child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  color: Color.fromRGBO(218, 218, 218, 1)),
                            ),
                          ),
                          child: RadioListTile<SigningCharacter>(
                              title: Text(
                                Languages.of(context)!.hireType,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              value: SigningCharacter.HIRE,
                              groupValue: _character,
                              onChanged: (SigningCharacter? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                              activeColor: Color.fromRGBO(0, 194, 255, 1)),
                        )),
                        Flexible(
                            child: Container(
                          child: RadioListTile<SigningCharacter>(
                              title: Text(
                                Languages.of(context)!.workType,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              value: SigningCharacter.WORK,
                              groupValue: _character,
                              onChanged: (SigningCharacter? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                              activeColor: Color.fromRGBO(0, 194, 255, 1)),
                        )),
                      ],
                    )),
                SizedBox(height: getProportionateScreenHeight(50)),
                isCreating
                    ? Center(child: CircularProgressIndicator())
                    : DefaultButton(
                        text: Languages.of(context)!.signup.toUpperCase(),
                        press: () async {
                          if (_character == null) return;
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              isCreating = true;
                            });
                            String userType =
                                _character == SigningCharacter.WORK
                                    ? "work"
                                    : "hire";
                            final response = await appService.createUser(
                                name: name,
                                email: email,
                                password: password,
                                latitude: latitude,
                                longitude: longitude,
                                userType: userType,
                                inviteCode: inviteCode,
                                device_id: deviceID,
                                firebase_token: mToken);
                            if (response is String || response == null) {
                              setState(() {
                                isCreating = false;
                              });
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message: response,
                                ),
                              );
                            } else {
                              setState(() {
                                isCreating = false;
                              });

                              if (_character == SigningCharacter.WORK) {
                                await appService.changeUserType(type: 'work');
                                GoRouter.of(context).pushReplacementNamed(
                                    APP_PAGE.workStep1.toName);
                              } else {
                                GoRouter.of(context)
                                    .pushReplacementNamed(APP_PAGE.home.toName);
                              }
                            }
                          }
                          firstSubmit = true;
                        },
                      ),
                SizedBox(height: getProportionateScreenHeight(24)),
                GrayButton(
                  text: Languages.of(context)!.signin.toUpperCase(),
                  press: () {
                    GoRouter.of(context).pushNamed(APP_PAGE.signIn.toName);
                  },
                ),
              ],
            ),
          );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newName) => this.name = newName!,
      onChanged: (name) {
        if (firstSubmit) _formKey.currentState!.validate();
      },
      validator: (name) {
        if (name!.isEmpty) {
          return Languages.of(context)!.kNameNullError;
        } else
          return null;
      },
      decoration: InputDecoration(
        labelText: Languages.of(context)!.name,
        hintText: Languages.of(context)!.inputName,
        suffixIcon:
            // this.name.isEmpty
            //     ? CustomSuffixIcon(iconPath: "assets/icons/User.svg")
            Icon(Icons.check),
      ),
      keyboardType: TextInputType.text,
    );
  }

  TextFormField buildInviteFormField() {
    return TextFormField(
      initialValue: this.inviteCode,
      onSaved: (iCode) => this.inviteCode = iCode!,
      onChanged: (code) {
        if (firstSubmit) _formKey.currentState!.validate();
      },
      decoration: InputDecoration(
        labelText: Languages.of(context)!.inviteCode,
        hintText: Languages.of(context)!.inputCode,
        suffixIcon: Icon(Icons.code),
      ),
      keyboardType: TextInputType.text,
    );
  }
}
