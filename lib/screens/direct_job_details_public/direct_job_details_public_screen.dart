import 'package:flutter/material.dart';
import 'package:localservice/size_config.dart';
import './components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/cubit/theme_module/provider/theme_cubit.dart';
import 'package:localservice/cubit/theme_module/states/change_theme_states.dart';
import 'package:localservice/theme/theme_colors.dart';

class DirectJobDetailsPublicScreen extends StatelessWidget {
  final String requestID;
  DirectJobDetailsPublicScreen({
    required this.requestID,
  });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
        bloc: changeThemeCubit,
        builder: (context, themeState) {
          return Scaffold(
            backgroundColor:
                themeState.customColors[AppColors.primaryBackgroundColor],
            body: Body(requestID: this.requestID),
            // bottomNavigationBar:
            //     CustomBottomNavigationBar(selectedMenu: Menu.profile),
          );
        });
  }
}
