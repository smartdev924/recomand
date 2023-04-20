import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/cubit/theme_module/provider/theme_cubit.dart';
import 'package:localservice/cubit/theme_module/states/change_theme_states.dart';
import 'package:localservice/localization/language/languages.dart';

import './sign_up_form.dart';
import '../../../size_config.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  String? inviteCode;
  Body({
    required this.inviteCode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
        bloc: changeThemeCubit,
        builder: (context, themeState) {
          return SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(25)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight! * 0.08),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          Languages.of(context)!.signup,
                          style: TextStyle(
                            color: themeState.isDarkTheme == true
                                ? Color.fromRGBO(218, 218, 218, 1)
                                : Colors.black,
                            fontSize: getProportionateScreenWidth(32),
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),

                      SizedBox(height: SizeConfig.screenHeight! * 0.06),
                      SignUpForm(codeInvited: this.inviteCode),
                      SizedBox(height: SizeConfig.screenHeight! * 0.06),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     SocialCard(
                      //       icon: "assets/icons/google-icon.svg",
                      //       press: () {},
                      //     ),
                      //     SocialCard(
                      //       icon: "assets/icons/facebook-2.svg",
                      //       press: () {},
                      //     ),
                      //     SocialCard(
                      //       icon: "assets/icons/twitter.svg",
                      //       press: () {},
                      //     ),
                      //   ],
                      // ),

                      // SizedBox(height: getProportionateScreenHeight(20)),
                      // Text(
                      //   "By continuing you confirm that you agree\nwith our terms and conditions",
                      //   textAlign: TextAlign.center,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
