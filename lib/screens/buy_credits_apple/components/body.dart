import 'package:flutter/material.dart';
import 'package:localservice/screens/buy_credits_apple/components/stripe_payment.dart';

import 'In_app_purchase_payment.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.apple_rounded),
              ),
              Tab(
                icon: Icon(Icons.credit_card),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: InAppPurchasePayment(),
            ),
            Center(
              child: StripePayment(),
            ),
          ],
        ),
      ),
    );
  }
}
