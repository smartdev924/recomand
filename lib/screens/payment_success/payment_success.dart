import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/size_config.dart';

class PaymentSuccessScreen extends StatelessWidget {
  static const routeName = '/payment-success';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Color.fromRGBO(15, 203, 161, 1),
              size: 100,
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              Languages.of(context)!.thankyou,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              child: DefaultButton(
                  text: Languages.of(context)!.buyCredits,
                  press: () {
                    if (Platform.isIOS) {
                      GoRouter.of(context)
                          .pushNamed(APP_PAGE.buyCreditsApple.toName);
                    } else {
                      GoRouter.of(context)
                          .pushNamed(APP_PAGE.buyCredits.toName);
                    }
                  }),
            )
          ],
        )),
      ),
      // bottomNavigationBar:
      //     CustomBottomNavigationBar(selectedMenu: Menu.topcategories),
    );
  }

  // PreferredSize appBar(BuildContext context) {
  //   return PreferredSize(
  //     child: Container(
  //       child: AppBar(
  //         leading: IconButton(
  //             icon: Icon(
  //               Icons.chevron_left,
  //             ),
  //             onPressed: (() => GoRouter.of(context).pop())),
  //         elevation: 0.0,
  //         title: Column(
  //           children: [
  //             Text(
  //               'Stripe',
  //               style: TextStyle(
  //                   fontSize: getProportionateScreenWidth(20),
  //                   fontWeight: FontWeight.w600),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     preferredSize: Size.fromHeight(kToolbarHeight),
  //   );
  // }
}
