import 'package:flutter/material.dart';
import 'package:localservice/services/AppService.dart';
import './components/body.dart';
import '../../components/custom_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';

class RequestDeeplinkScreen extends StatelessWidget {
  static const routeName = '/request/:requestID';
  final String requestID;
  RequestDeeplinkScreen({
    required this.requestID,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context
          .watch<AppService>()
          .themeState
          .customColors[AppColors.primaryBackgroundColor],
      body: Body(requestID: this.requestID),
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedMenu: Menu.profile),
    );
  }
}
