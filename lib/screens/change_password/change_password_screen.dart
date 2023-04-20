import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';
import './components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:localservice/localization/language/languages.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = '/change-password';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: appBar(context),
      backgroundColor: context
          .watch<AppService>()
          .themeState
          .customColors[AppColors.primaryBackgroundColor],
      body: Body(),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: (() => GoRouter.of(context).pop())),
      title: Column(
        children: [
          Text(
            Languages.of(context)!.changepassword,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
