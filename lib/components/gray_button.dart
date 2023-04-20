import 'package:flutter/material.dart';
import 'package:localservice/services/AppService.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';

import 'package:localservice/theme/theme_colors.dart';

class GrayButton extends StatelessWidget {
  const GrayButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
            fontSize: getProportionateScreenWidth(15),
            color: context
                .watch<AppService>()
                .themeState
                .customColors[AppColors.secondaryButtonTextColor],
            fontWeight: FontWeight.w500),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(context
            .watch<AppService>()
            .themeState
            .customColors[AppColors.secondaryButtonColor]),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(
            getProportionateScreenWidth(double.infinity),
            getProportionateScreenHeight(53),
          ),
        ),
      ),
    );
  }
}
