import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/services/AppService.dart';
import 'package:provider/provider.dart';
import './sign_in_form.dart';
import '../../../size_config.dart';
import 'package:localservice/localization/language/languages.dart';
// import 'package:localservice/localization/locale_constant.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    Languages.of(context)!.signin,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(32),
                      fontWeight: FontWeight.bold,
                      color:
                          context.watch<AppService>().themeState.isDarkTheme ==
                                  true
                              ? Color.fromRGBO(218, 218, 218, 1)
                              : Colors.black,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
