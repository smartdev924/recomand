import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';

import './components/body.dart';
import '../../components/custom_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';

// update
class MyServicesScreen extends StatelessWidget {
  static const routeName = '/my-services';

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
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedMenu: Menu.profile),
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
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
              icon: Icon(
                Icons.add_box_rounded,
                size: 25,
                color: Colors.black,
              ),
              onPressed: (() {})),
        )
      ],
      title: Column(
        children: [
          Text(
            Languages.of(context)!.myServices,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
