import 'package:flutter/material.dart';
import 'package:localservice/services/AppService.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';

import 'package:localservice/theme/theme_colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    late AppService _appService =
        Provider.of<AppService>(context, listen: false);
    return ElevatedButton(
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
            fontSize: getProportionateScreenWidth(15),
            color:
                _appService.themeState.customColors[AppColors.buttonTextColor],
            fontWeight: FontWeight.w500),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            _appService.themeState.customColors[AppColors.primaryButtonColor]),
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
