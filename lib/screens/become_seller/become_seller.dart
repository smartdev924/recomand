import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';

import './components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';

// update
class BecomeSellerScreen extends StatelessWidget {
  static const routeName = '/become-seller';

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
      title: Column(
        children: [
          Text(
            Languages.of(context)!.become_seller.toUpperCase(),
            style: TextStyle(
                fontSize: getProportionateScreenWidth(22),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
