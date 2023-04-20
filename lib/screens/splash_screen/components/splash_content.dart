import 'package:flutter/material.dart';
import 'package:localservice/theme/theme_colors.dart';

import '../../../size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/cubit/theme_module/provider/theme_cubit.dart';
import 'package:localservice/cubit/theme_module/states/change_theme_states.dart';
import 'package:localservice/localization/language/languages.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
        bloc: changeThemeCubit,
        builder: (context, themeState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              Text(
                "LocalServices",
                style: TextStyle(
                  fontSize: 48,
                  fontFamily: "Roboto",
                  color: themeState.customColors[AppColors.SloganColor],
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(24),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Image.asset(
                    'assets/images/request.png',
                    fit: BoxFit.cover,
                    width: 50,
                  )),
                  SizedBox(width: 18),
                  Container(
                      child: Text(
                        Languages.of(context)!.send_splash,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      width: getProportionateScreenWidth(270)),
                ],
              ),
              Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Image.asset(
                    'assets/images/offer.png',
                    fit: BoxFit.cover,
                    width: 50,
                  )),
                  SizedBox(width: 18),
                  Container(
                      child: Text(
                        Languages.of(context)!.receive_splash,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      width: getProportionateScreenWidth(270)),
                ],
              ),
              Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Image.asset(
                    'assets/images/expert.png',
                    fit: BoxFit.cover,
                    width: 50,
                  )),
                  SizedBox(width: 18),
                  Container(
                      child: Text(
                        Languages.of(context)!.choose_splash,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      width: getProportionateScreenWidth(270)),
                ],
              ),
            ],
          );
        });
  }
}
