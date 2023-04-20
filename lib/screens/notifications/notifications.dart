import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/localization/language/languages.dart';
import './components/body.dart';
import '../../size_config.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBar(context),
      body: Body(),
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
                Languages.of(context)!.notificaiton,
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
