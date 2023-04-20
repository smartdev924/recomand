import 'package:flutter/material.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/theme/theme_colors.dart';
import './components/body.dart';
import '../../size_config.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CountryScreen extends StatelessWidget {
  static const String routeName = "/country-screen";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context
          .watch<AppService>()
          .themeState
          .customColors[AppColors.primaryBackgroundColor],
      body: Body(),
    );
  }
}
