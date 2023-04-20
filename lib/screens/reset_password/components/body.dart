import 'package:flutter/material.dart';

// import '../../../constants.dart';
import 'reset_password_form.dart';
import '../../../size_config.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.06),
                Text(
                  Languages.of(context)!.resetpass_description,
                  // style: headingStyle,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: getProportionateScreenWidth(15)),
                ),
                // Text(
                //   "Complete your details or continue\nwith social media",
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: SizeConfig.screenHeight! * 0.06),
                ResetPasswordForm(),
                SizedBox(height: SizeConfig.screenHeight! * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
