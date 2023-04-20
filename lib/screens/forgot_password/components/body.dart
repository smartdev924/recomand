import 'package:flutter/material.dart';
import '../../../size_config.dart';
import './forgot_password_form.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * 0.06),
              Text(
                Languages.of(context)!.forgotpassword_description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: getProportionateScreenWidth(15)),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.08),
              ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
