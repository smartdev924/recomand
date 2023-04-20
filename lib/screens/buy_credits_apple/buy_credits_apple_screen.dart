import 'package:flutter/material.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';
import 'components/body.dart';
import '../../components/custom_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:go_router/go_router.dart';

class BuyCreditsAppleScreen extends StatelessWidget {
  static const routeName = '/buy-credits-apple';
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
          CustomBottomNavigationBar(selectedMenu: Menu.browseRequests),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: (() {
            // if (_appService.user['credits'] == 0 &&
            //     _appService.user['is_worker'] == true &&
            //     _appService.user['user_type'] == 'work') return;
            GoRouter.of(context).pop();
          })),
      title: Column(
        children: [
          Text(
            Languages.of(context)!.buyCredits,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(22),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      actions: [
        Image.asset(
          'assets/images/money_sack.png',
          fit: BoxFit.cover,
          width: 55,
          color: context.watch<AppService>().themeState.isDarkTheme == true
              ? Colors.white
              : Colors.black,
        ),
        SizedBox(
          width: 40,
        )
      ],
    );
  }
}
