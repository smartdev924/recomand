import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:go_router/go_router.dart';

enum SigningCharacter { PRIVATE, COMPANY }

class Body extends StatefulWidget {
  const Body(
      // key? key,
      );
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  final _formKey = GlobalKey<FormState>();
  bool isSending = false;
  bool firstSubmit = false;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  String profileDescription = '';
  String companyName = '';
  String companyNumber = '';
  String address = '';
  String price = '';
  String deadline = '';
  String phone = '';
  String website = '';
  String youtoue = '';
  String facebook = '';
  String tiktok = '';
  String whatsapp = "";
  String latitude = "";
  String longitude = "";
  SigningCharacter? _character = SigningCharacter.PRIVATE;
  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    if (kIsWeb)
      _determinePosition();
    else if (Platform.isAndroid || Platform.isIOS) _determinePosition();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await _geolocatorPlatform.openLocationSettings();

      latitude = 'Location services';
      longitude = 'are disabled';

      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await _geolocatorPlatform.openLocationSettings();
        latitude = 'Permission';
        longitude = 'denied';
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      latitude = 'Permission';
      longitude = 'permanently denied';
      await _geolocatorPlatform.openAppSettings();

      return;
    }
    Position _position = await Geolocator.getCurrentPosition();
    if (!mounted) return;
    setState(() {
      longitude = _position.longitude.toString();
      latitude = _position.latitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                          child: Row(
                        children: [
                          Flexible(
                              child: Container(
                            child: RadioListTile<SigningCharacter>(
                                title: Text(
                                  Languages.of(context)!.private,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: context
                                            .watch<AppService>()
                                            .themeState
                                            .customColors[
                                        AppColors.primaryTextColor1],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                value: SigningCharacter.PRIVATE,
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
                                  Languages.of(context)!.company,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                            .watch<AppService>()
                                            .themeState
                                            .customColors[
                                        AppColors.primaryTextColor1],
                                  ),
                                ),
                                value: SigningCharacter.COMPANY,
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
                      TextFormField(
                        onChanged: (value) {
                          if (firstSubmit) _formKey.currentState!.validate();
                          setState(() {
                            companyName = value;
                          });
                        },
                        validator: (companyName) {
                          if (companyName!.isEmpty) {
                            return Languages.of(context)!
                                .companyNameValidateError;
                          }
                          return null;
                        },
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: Languages.of(context)!
                                  .companyNameHint
                                  .toUpperCase() +
                              "  *",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      if (_character == SigningCharacter.COMPANY)
                        SizedBox(
                          height: 10,
                        ),
                      if (_character == SigningCharacter.COMPANY)
                        TextFormField(
                          onChanged: (value) {
                            if (firstSubmit) _formKey.currentState!.validate();
                            setState(() {
                              companyNumber = value;
                            });
                          },
                          validator: (companyNumber) {
                            if (companyNumber!.isEmpty) {
                              return Languages.of(context)!
                                  .companyNumberValidateError;
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Languages.of(context)!
                                    .companyNumberHint
                                    .toUpperCase() +
                                " *",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          if (firstSubmit) _formKey.currentState!.validate();
                          setState(() {
                            address = value;
                          });
                        },
                        validator: (address) {
                          if (address!.isEmpty) {
                            return Languages.of(context)!.kAddressNullError;
                          }
                          return null;
                        },
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText:
                              Languages.of(context)!.address.toUpperCase() +
                                  "  *",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          if (firstSubmit) _formKey.currentState!.validate();
                          setState(() {
                            phone = value;
                          });
                        },
                        validator: (phone) {
                          if (phone!.isEmpty) {
                            return Languages.of(context)!.kPhoneNumberNullError;
                          }
                          return null;
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText:
                              Languages.of(context)!.phone.toUpperCase() +
                                  "  *",
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          if (firstSubmit) _formKey.currentState!.validate();
                          setState(() {
                            profileDescription = value;
                          });
                        },
                        validator: (profileDescription) {
                          if (profileDescription!.isEmpty) {
                            return Languages.of(context)!.kDescriptionNullError;
                          }
                          return null;
                        },
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: Languages.of(context)!
                                  .profileDescriptionHint
                                  .toUpperCase() +
                              "  *",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          if (firstSubmit)
                            setState(() {
                              website = value;
                            });
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: "WEBSITE " +
                              Languages.of(context)!.optional.toUpperCase(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          if (firstSubmit)
                            setState(() {
                              youtoue = value;
                            });
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: "YOUTOUBE " +
                              Languages.of(context)!.optional.toUpperCase(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          if (firstSubmit)
                            setState(() {
                              facebook = value;
                            });
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: "FACEBOOK PAGE " +
                              Languages.of(context)!.optional.toUpperCase(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            tiktok = value;
                          });
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: "TIKTOK " +
                              Languages.of(context)!.optional.toUpperCase(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            whatsapp = value;
                          });
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: "WHATSAPP " +
                              Languages.of(context)!.optional.toUpperCase(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ))),
        bottomNavigationBar: isSending
            ? Container(
                alignment: Alignment.center,
                width: 30,
                height: 30,
                child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(10),
                child: DefaultButton(
                    text: Languages.of(context)!.lab_send,
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          isSending = true;
                        });

                        dynamic response = await _appService.becomeSeller(
                            company_name: companyName,
                            company_number: companyNumber,
                            address: address,
                            phone: phone,
                            description: profileDescription,
                            website: website,
                            tiktok: tiktok,
                            facebook: facebook,
                            whatsapp: whatsapp,
                            youtube: youtoue,
                            lat: latitude,
                            lon: longitude);
                        setState(() {
                          isSending = false;
                        });

                        if (response is String || response == null) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: response,
                            ),
                          );
                        } else {
                          dynamic response =
                              await _appService.changeUserType(type: "work");
                          if (response is String || response == null)
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                message: response,
                              ),
                            );
                          else if (response.data['success'] == false)
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                message: response.data['message'],
                              ),
                            );
                          else {
                            _appService.user['is_worker'] = true;
                            _appService.user['user_type'] = 'work';
                            await _appService.changeUserType(type: 'work');

                            final response = await _appService.getUserInfo();
                            if (response != String && response != null) {
                              _appService.user = response.data['data'];
                              await _appService.saveUserData();

                              if (_appService.user['is_approved'])
                                GoRouter.of(context)
                                    .pushNamed(APP_PAGE.becomeSuccess.toName);
                            } else {
                              print(response);
                            }
                          }
                        }
                      }
                      firstSubmit = true;
                    })));
  }
}
