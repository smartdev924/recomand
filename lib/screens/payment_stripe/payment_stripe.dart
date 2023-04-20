import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './components/body.dart';
import '../../../size_config.dart';

class PaymentStripeScreen extends StatelessWidget {
  static const routeName = '/payment-stripe';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      // appBar: appBar(context),
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
          title: Column(
            children: [
              Text(
                'Stripe',
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
