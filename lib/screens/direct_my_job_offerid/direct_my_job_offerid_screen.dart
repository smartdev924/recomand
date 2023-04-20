import 'package:flutter/material.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';

import './components/body.dart';
import '../../components/custom_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/localization/language/languages.dart';

// update
class DirectMyJobOfferidScreen extends StatelessWidget {
  static const routeName = '/direct-my-job-offerid/:offerID';
  final String offerID;
  DirectMyJobOfferidScreen({
    required this.offerID,
  });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: context
          .watch<AppService>()
          .themeState
          .customColors[AppColors.primaryBackgroundColor],
      appBar: appBar(context),
      body: Body(
        offerID: this.offerID,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedMenu: Menu.home),
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
            Languages.of(context)!.job_offer,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
