import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
// import 'package:localservice/screens/splash_screen/splash_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/gray_button.dart';
import 'package:localservice/models/user_info.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/localization/language/languages.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  QuickActions quickActions = const QuickActions();

  late String email, password;
  late AppService _appService;
  bool firstSubmit = false;
  // bool remember = false;
  bool isSigning = false;
  bool isHide = true;
  bool isEmail = false;
  UserInfo? user;
  String? mToken;
  String? deviceID;
  @override
  void initState() {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) getToken();
    getDeviceID();
    _appService = Provider.of<AppService>(context, listen: false);
    super.initState();
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
      initializeQuickActions(_appService.contextData);
  }

  initializeQuickActions(BuildContext context) {
    quickActions.initialize((String shortcutType) {
      switch (shortcutType) {
        case 'client':
          return;
        case 'provider':
          return;
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
          type: 'client',
          localizedTitle: Languages.of(context)!.clientMode,
          icon: "launcher_icon"),
      ShortcutItem(
          type: 'provider',
          localizedTitle: Languages.of(context)!.providerMode,
          icon: "launcher_icon"),
    ]);
  }

  sendPushNotification(String data) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode({
          'notification': <String, dynamic>{
            'title': 'Welcome',
            'body': data,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': mToken
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAGzx7K-Y:APA91bFElqv5RFCB1AixBCli1pmcpsUVJ5K8XzF_OFWW594W0YiDcmome1PJNu5EhRBfXJsjVMvxhUPpINFT0qDxiGmd_hGzlCjCSC8FM13wrhMF3HPcUUUj-C66i6d96fhvbp8LKIHN'
        },
      );
    } catch (e) {}
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mToken = token!;
      });
    });
  }

  void getDeviceID() async {
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    setState(() {
      deviceID = deviceId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            onSaved: (newPassword) => this.password = newPassword!,
            onChanged: (password) {
              if (firstSubmit) _formKey.currentState!.validate();
              this.password = password;
            },
            validator: (password) {
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
          SizedBox(height: getProportionateScreenHeight(30)),
          isSigning
              ? CircularProgressIndicator()
              : DefaultButton(
                  text: Languages.of(context)!.signin.toUpperCase(),
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isSigning = true;
                      });
                      dynamic response = await _appService.loginUser(
                          email: email,
                          password: password,
                          firebase_token: mToken,
                          device_id: deviceID);
                      setState(() {
                        isSigning = false;
                      });

                      if (response is String || response == null) {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: response,
                          ),
                        );
                      } else {
                        if (_appService.user['is_worker'] == false) {
                          GoRouter.of(context)
                              .pushReplacementNamed(APP_PAGE.home.toName);
                        } else if (_appService.user['user_type'] == "hire") {
                          GoRouter.of(context)
                              .pushReplacementNamed(APP_PAGE.home.toName);
                        } else {
                          // if (_appService.user['credits'] == 0) {
                          //   if (Platform.isIOS) {
                          //     GoRouter.of(context).pushNamed(
                          //         APP_PAGE.buyCreditsApple.toName);
                          //   } else {
                          //     GoRouter.of(context)
                          //         .pushNamed(APP_PAGE.buyCredits.toName);
                          //   }
                          // } else {
                          if (_appService.user['is_approved'] == false)
                            GoRouter.of(context).pushReplacementNamed(
                                APP_PAGE.workStep1.toName);
                          else
                            GoRouter.of(context).pushReplacementNamed(
                                APP_PAGE.browseRequests.toName);
                          // }
                        }
                      }
                    }
                    firstSubmit = true;
                  },
                ),
          SizedBox(height: getProportionateScreenHeight(24)),
          GrayButton(
            text: Languages.of(context)!.createaccount.toUpperCase(),
            press: () {
              GoRouter.of(context).pushNamed(APP_PAGE.signUp.toName,
                  params: {"inviteCode": 'nocode'});
            },
          ),
        ],
      ),
    );
  }
}
