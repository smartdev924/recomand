import 'package:flutter/material.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';

import './components/body.dart';
import '../../components/custom_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:go_router/go_router.dart';

// update
class MyOffersScreen extends StatelessWidget {
  static const routeName = '/my-offers';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: context
          .watch<AppService>()
          .themeState
          .customColors[AppColors.primaryBackgroundColor],
      appBar: appBar(context),
      body: Body(),
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedMenu: Menu.profile),
    );
  }

  AppBar appBar(
    BuildContext context,
  ) {
    return AppBar(
      centerTitle: true,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: context.watch<AppService>().themeState.isDarkTheme == true
              ? SizedBox()
              : Container(
                  color: Color.fromARGB(255, 231, 231, 231),
                  height: 1.0,
                )),
      leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: (() => GoRouter.of(context).pop())),
      title: Column(
        children: [
          Text(
            Languages.of(context)!.myOffers,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(22),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
