import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';

class Body extends StatefulWidget {
  Body();
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  build(context) => Scaffold(
        bottomNavigationBar: Container(
            padding: EdgeInsets.all(10),
            child: DefaultButton(
                text: Languages.of(context)!.close,
                press: () async {
                  GoRouter.of(context)
                      .pushNamed(APP_PAGE.browseRequests.toName);
                })),
        body: Column(children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/images/request_success.png',
            fit: BoxFit.cover,
            width: 90,
            // height: double.infinity,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            Languages.of(context)!.Congratulation + "s!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color:
                    context.watch<AppService>().themeState.isDarkTheme == false
                        ? Color.fromRGBO(43, 44, 46, 1)
                        : Colors.white70),
          ),
          SizedBox(
            height: 26,
          ),
          Text(
            Languages.of(context)!.becomeSellerApproved,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color:
                    context.watch<AppService>().themeState.isDarkTheme == false
                        ? Color.fromRGBO(43, 44, 46, 1)
                        : Colors.white70),
          ),
          SizedBox(
            height: 25,
          ),
        ]),
      );
}
