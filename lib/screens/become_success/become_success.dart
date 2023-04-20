import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/custom_bottom_navigation_bar.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/size_config.dart';
import './components/body.dart';

class BecomeSuccessScreen extends StatefulWidget {
  static var routeName = "/becoem-success";
  @override
  _BecomeSuccessScreenState createState() => _BecomeSuccessScreenState();
}

class _BecomeSuccessScreenState extends State<BecomeSuccessScreen> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBar(context),
      body: Body(),
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedMenu: Menu.profile),
    );
  }

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      child: Container(
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
              ),
              onPressed: (() => GoRouter.of(context).pop())),
          title: Column(
            children: [
              Text(
                Languages.of(context)!.become_seller.toUpperCase(),
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(22),
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }
}
