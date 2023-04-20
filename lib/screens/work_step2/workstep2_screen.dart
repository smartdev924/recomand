import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';
import './components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/theme/theme_colors.dart';

class WorkStep2Screen extends StatelessWidget {
  static const String routeName = '/work-step2';

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
                Icons.close,
                size: 30,
                color: Colors.grey,
              ),
              onPressed: (() {
                showModalBottomSheet<void>(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 10, bottom: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            Languages.of(context)!.areyousure,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(43, 44, 46, 1)),
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(248, 248, 248, 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  Languages.of(context)!.go_on,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(43, 44, 46, 1)),
                                ),
                              )),
                          SizedBox(
                            height: 11,
                          ),
                          InkWell(
                              onTap: () => GoRouter.of(context)
                                  .pushNamed(APP_PAGE.workStep1.toName),
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(232, 104, 111, 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  Languages.of(context)!.quit,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(43, 44, 46, 1)),
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                );
              })),
        )
      ],
      title: Column(
        children: [
          Text(
            Languages.of(context)!.BECOME_SELLER,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
