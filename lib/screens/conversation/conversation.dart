import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './components/body.dart';
import '../../size_config.dart';
import '../../components/custom_bottom_navigation_bar.dart';
import 'package:localservice/localization/language/languages.dart';

class ConversationScreen extends StatelessWidget {
  static const routeName = '/conversation';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // appBar: appBar(context),
      body: Body(),
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedMenu: Menu.message),
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
                Languages.of(context)!.conversations,
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
