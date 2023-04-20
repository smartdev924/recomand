import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localservice/localization/language/languages.dart';

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late String password, confirmPassword;
  final List<String> errors = [];
  bool firstSubmit = false;
  bool remember = false;
  bool isReseting = false;

  String? resetcode, email;
  late AppService _appService;
  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    getResetCode();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> getResetCode() async {
    var preferences = await SharedPreferences.getInstance();
    final resetvalue = await preferences.getString('resetcode');

    final emailvalue = await preferences.getString('resetpasswordemail');
    if (!mounted) return;
    setState(() => resetcode = resetvalue);
    setState(() => email = emailvalue);
    // return resetcode;
  }

  @override
  Widget build(BuildContext context) {
    // getResetCode().then((value) => null);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailCodeFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          isReseting
              ? CircularProgressIndicator()
              : DefaultButton(
                  text: Languages.of(context)!.changepassword,
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isReseting = true;
                      });
                      final response = await _appService.resetPassword(
                        email: email!,
                        email_code: resetcode!,
                        new_password: password,
                      );
                      if (response is String || response == null) {
                        setState(() {
                          isReseting = false;
                        });
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: response,
                          ),
                        );
                      } else {
                        setState(() {
                          isReseting = false;
                        });
                        GoRouter.of(context).pushNamed(APP_PAGE.signIn.toName);
                      }
                    }
                    firstSubmit = true;
                  },
                ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: TextEditingController(text: email),
      decoration: InputDecoration(
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Mail.svg"),
      ),
      style: (TextStyle(color: Colors.grey)),
      enabled: false,
      keyboardType: TextInputType.emailAddress,
    );
  }

  TextFormField buildEmailCodeFormField() {
    return TextFormField(
      controller: TextEditingController(text: resetcode),
      style: (TextStyle(color: Colors.grey)),
      enabled: false,
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
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
      decoration: InputDecoration(
        labelText: Languages.of(context)!.password,
        hintText: Languages.of(context)!.pleaseenteryourpassword,
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      onSaved: (newPassword) => this.confirmPassword = newPassword!,
      onChanged: (password) {
        if (firstSubmit) _formKey.currentState!.validate();
      },
      validator: (password) {
        if (password != this.password) {
          return Languages.of(context)!.kMatchPassError;
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: Languages.of(context)!.confirmpassword,
        hintText: Languages.of(context)!.confirmpassword,
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }
}
