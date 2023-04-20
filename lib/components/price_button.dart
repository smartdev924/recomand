import 'package:flutter/material.dart';
import 'package:localservice/services/AppService.dart';

import '../size_config.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';

class PriceButton extends StatelessWidget {
  const PriceButton({
    Key? key,
    required this.text,
    required this.price,
    required this.press,
  }) : super(key: key);
  final String text;
  final String price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: context
                    .watch<AppService>()
                    .themeState
                    .customColors[AppColors.buttonTextColor],
                fontWeight: FontWeight.w500),
          ),
          Text(
            price,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: context
                    .watch<AppService>()
                    .themeState
                    .customColors[AppColors.buttonTextColor],
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(context
            .watch<AppService>()
            .themeState
            .customColors[AppColors.primaryButtonColor]),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
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
