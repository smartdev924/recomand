import 'package:flutter/material.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/theme/theme_colors.dart';

import '../../../size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    // required this.press,
  }) : super(key: key);

  final String title;
  // final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color.fromRGBO(100, 174, 223, 1)),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: context
                      .watch<AppService>()
                      .themeState
                      .customColors[AppColors.primaryTextColor1],
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
