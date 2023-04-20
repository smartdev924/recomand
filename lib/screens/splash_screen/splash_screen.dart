import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import './components/body.dart';
import '../../size_config.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash-screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool checkingInstalled = false;
  @override
  void initState() {
    super.initState();

    controlNavigateScreen();
  }

  void controlNavigateScreen() async {
    if (!mounted) return;

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Timer(Duration(seconds: 2), () {
        GoRouter.of(context).pushReplacementNamed(APP_PAGE.country.toName);
      });
    });
  }

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
