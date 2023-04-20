import 'package:flutter/material.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import './components/body.dart';
import './components/forgot_password_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen();
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late AppService _appService;

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _appService.contextData = context;

    return UpgradeAlert(
        upgrader: Upgrader(
          durationUntilAlertAgain: Duration(days: 1),
          dialogStyle: UpgradeDialogStyle.cupertino,
        ),
        child: Scaffold(
          backgroundColor: _appService
              .themeState.customColors[AppColors.primaryBackgroundColor],
          body: Body(),
          bottomNavigationBar: ForgotPasswordButton(),
        ));
  }
}
