import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/services/AppService.dart';
import './components/body.dart';
import '../../../size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';

class PaymentMethodScreen extends StatelessWidget {
  static const routeName = '/payment-method';

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
      // bottomNavigationBar:
      // CustomBottomNavigationBar(selectedMenu: Menu.topcategories),
    );
  }

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      child: Container(
        child: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
              ),
              onPressed: (() => GoRouter.of(context).pop())),
          elevation: 0.0,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                Languages.of(context)!.paymentMethod,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }
}
