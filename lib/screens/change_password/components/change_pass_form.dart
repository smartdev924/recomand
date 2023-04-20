import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/services/AppService.dart';

import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late String currentPass, password, confirmPassword;
  final List<String> errors = [];
  late AppService _appService;
  bool firstSubmit = false;
  bool remember = false;
  bool isCreating = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appService = Provider.of<AppService>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(40)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildNewPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildConfirmNewPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          isCreating
              ? CircularProgressIndicator()
              : DefaultButton(
                  text: Languages.of(context)!.changepassword,
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isCreating = true;
                      });
                      final user = await _appService.changePassword(
                          password: currentPass, new_password: password);
                      if (user == null) {
                        setState(() {
                          isCreating = false;
                        });
                      } else {
                        setState(() {
                          isCreating = false;
                        });
                      }
                    }
                    firstSubmit = true;
                  },
                ),
          SizedBox(height: getProportionateScreenHeight(24)),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (currentPassword) => this.currentPass = currentPassword!,
      onChanged: (currentPass) {
        if (firstSubmit) _formKey.currentState!.validate();
      },
      validator: (currentPass) {
        if (currentPass!.isEmpty) {
          return Languages.of(context)!.kPassNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: Languages.of(context)!.currentpassword,
        hintText: Languages.of(context)!.enteryourcurrentpassword,
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }

  TextFormField buildNewPasswordFormField() {
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
        labelText: Languages.of(context)!.newpassword,
        hintText: Languages.of(context)!.enteryournewpassword,
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }

  TextFormField buildConfirmNewPasswordFormField() {
    return TextFormField(
      onSaved: (newPassword) => this.confirmPassword = newPassword!,
      onChanged: (password) {
        if (firstSubmit) _formKey.currentState!.validate();
      },
      validator: (password) {
        if (password!.isEmpty) {
          return Languages.of(context)!.kPassNullError;
        } else if (password != this.password) {
          return Languages.of(context)!.kShortPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: Languages.of(context)!.confirmnewpassword,
        hintText: Languages.of(context)!.repeatyournewpassword,
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }
}
