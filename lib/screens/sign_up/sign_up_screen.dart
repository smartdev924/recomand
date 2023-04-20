import 'package:flutter/material.dart';
import 'package:localservice/size_config.dart';
import 'package:upgrader/upgrader.dart';

import './components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/cubit/theme_module/provider/theme_cubit.dart';
import 'package:localservice/cubit/theme_module/states/change_theme_states.dart';
import 'package:localservice/theme/theme_colors.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/register/:inviteCode';
  final String? inviteCode;
  SignUpScreen({
    this.inviteCode,
  });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocBuilder<ThemeCubit, ChangeThemeState>(
        bloc: changeThemeCubit,
        builder: (context, themeState) {
          return UpgradeAlert(
              upgrader: Upgrader(
                durationUntilAlertAgain: Duration(days: 1),
                dialogStyle: UpgradeDialogStyle.cupertino,
              ),
              child: Scaffold(
                backgroundColor:
                    themeState.customColors[AppColors.primaryBackgroundColor],
                body: Body(
                  inviteCode: this.inviteCode,
                ),
              ));
        });
  }
}
