import 'package:flutter/material.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';
import './components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';

class HireStep1Screen extends StatelessWidget {
  static const String routeName = '/hire-step1';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context
          .watch<AppService>()
          .themeState
          .customColors[AppColors.primaryBackgroundColor],
      // appBar: appBar(context),
      body: Body(),
    );
  }
}
