import 'package:localservice/components/gray_button.dart';
import 'package:localservice/constants.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:localservice/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../size_config.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();

  Body();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  final _formKey = GlobalKey<FormState>();
  late String email, name = "", phoneNumber = '', address = "";
  List<String> dialCodeList = ['+40', '+39', '+37'];
  String countryCode = '';
  bool firstSubmit = false;
  bool isEmail = false;
  bool isUpdating = false;

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    setState(() {
      name = _appService.user['full_name'] ?? "";
      email = _appService.user['email'];
      phoneNumber = _appService.user['phone'] ?? "";
      countryCode = dialCodeList.first;
      address = _appService.user['address'] ?? "";
    });

    super.initState();
  }

  Future<void> submitName(String f_name) async {
    UserInfo user = UserInfo();
    try {
      user.fullName = f_name;
      user.tz = _appService.user["tz"];
      user.email = _appService.user["email"];
      final response = await _appService.updateUserName(user: user);
      if (response is String) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: response,
          ),
        );
      } else {
        setState(() => {
              // userName = response.data['full_name'],
            });
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 30),
            Text(
              Languages.of(context)!.myDetails,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: context
                      .watch<AppService>()
                      .themeState
                      .customColors[AppColors.primaryTextColor1]),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            TextFormField(
              initialValue: name,
              onSaved: (newName) => this.name = newName!,
              onChanged: (value) {
                if (firstSubmit) _formKey.currentState!.validate();
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                labelText: Languages.of(context)!.name,
                hintText: Languages.of(context)!.inputName,
                suffixIcon: Icon(Icons.check),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            TextFormField(
              onSaved: (newEmail) => this.email = newEmail!,
              initialValue: email,
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
            Row(
              children: [
                Container(
                  width: 80,
                  child: DropdownButton<String>(
                    value: countryCode,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 8,
                    isExpanded: true,
                    style: const TextStyle(
                        color: Color.fromRGBO(139, 139, 151, 1)),
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    alignment: AlignmentDirectional.center,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        countryCode = value!;
                      });
                    },
                    items: dialCodeList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: getProportionateScreenHeight(15)),
                Expanded(
                  child: TextFormField(
                    onSaved: (newNumber) => this.phoneNumber = newNumber!,
                    onChanged: (value) {
                      if (firstSubmit) _formKey.currentState!.validate();
                      setState(() {
                        phoneNumber = value;
                      });
                    },
                    initialValue: phoneNumber,
                    decoration: InputDecoration(
                      labelText: Languages.of(context)!.phone,
                      hintText: Languages.of(context)!.enterPhone,
                      suffixIcon: Icon(Icons.check),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            TextFormField(
              onSaved: (newAddress) => this.address = newAddress!,
              onChanged: (value) {
                if (firstSubmit) _formKey.currentState!.validate();
                setState(() {
                  address = value;
                });
              },
              initialValue: address,
              decoration: InputDecoration(
                labelText: Languages.of(context)!.address,
                hintText: Languages.of(context)!.address,
                suffixIcon: Icon(Icons.edit_location),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: getProportionateScreenHeight(56)),
            isUpdating
                ? Container(child: Center(child: CircularProgressIndicator()))
                : GrayButton(
                    text: Languages.of(context)!.save.toUpperCase(),
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          isUpdating = true;
                        });
                        dynamic response = await _appService.updateProfile(
                            full_name: name == "" ? null : name,
                            email: email,
                            phone_number:
                                phoneNumber == "" ? null : phoneNumber,
                            country_code:
                                phoneNumber == "" ? null : countryCode,
                            address: address == "" ? null : address);
                        setState(() {
                          isUpdating = false;
                        });
                        if (response is String || response == null) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: response,
                            ),
                          );
                        } else {
                          await _appService.getUserInfo();
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(
                              message: "Successfully updated!",
                            ),
                          );
                        }
                      }
                      // GoRouter.of(context)
                      //     .pushNamed(APP_PAGE.myAccountSettings.toName);
                    })
          ]),
        ),
      ),
    );
  }
}
