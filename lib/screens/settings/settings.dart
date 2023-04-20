import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './components/body.dart';
import '../../size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:localservice/cubit/theme_module/provider/theme_cubit.dart';
import 'package:localservice/cubit/theme_module/states/change_theme_states.dart';
import 'package:localservice/theme/theme_colors.dart';

import 'package:localservice/localization/language/languages.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocBuilder<ThemeCubit, ChangeThemeState>(
        bloc: changeThemeCubit,
        builder: (context, themeState) {
          return Scaffold(
            backgroundColor:
                themeState.customColors[AppColors.primaryBackgroundColor],
            appBar: appBar(context),
            body: Body(),
          );
        });
  }

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      child: Container(
        child: AppBar(
          leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: (() => GoRouter.of(context).pop())),
          elevation: 0.0,
          centerTitle: true,
          actions: [],
          title: Column(
            children: [
              Text(
                Languages.of(context)!.lab_settings,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(22),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }
}
