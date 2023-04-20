import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';
import './components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';

class SubscriptionScreen extends StatelessWidget {
  static const String routeName = '/subscription';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: context
          .watch<AppService>()
          .themeState
          .customColors[AppColors.primaryBackgroundColor],
      appBar: appBar(context),
      body: Body(),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: (() => GoRouter.of(context).pop())),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
              icon: Icon(
                Icons.close,
                size: 25,
                color: Colors.black,
              ),
              onPressed: (() {})),
        )
      ],
      title: Column(
        children: [
          Text(
            Languages.of(context)!.BECOME_SELLER,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
