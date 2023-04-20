import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  bool isLoaded = false;
  dynamic myRequestList;

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: 303,
            child: buildImage(_appService.selectedServiceItemData['image']),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: Text(
                    _appService.selectedServiceItemData['name'],
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                false
                            ? Colors.black
                            : Colors.white70),
                  ),
                ),
                SizedBox(
                  height: 27,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      _appService.selectedServiceItemData['total_experts']
                              .toString() +
                          ' ' +
                          _appService.selectedServiceItemData['name'] +
                          ' ' +
                          Languages.of(context)!.servicesCompanyReady,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Colors.black
                              : Colors.white70),
                    ))
                  ],
                ),
                SizedBox(
                  height: 27,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      _appService.selectedServiceItemData['average_rating']
                              .toString() +
                          ' ' +
                          Languages.of(context)!.avg_rating +
                          '  ( ' +
                          _appService.selectedServiceItemData['total_experts']
                              .toString() +
                          ' ' +
                          Languages.of(context)!.verify_review +
                          ' )',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Colors.black
                              : Colors.white70),
                    ))
                  ],
                ),
                SizedBox(
                  height: 27,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.library_add_check_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      Languages.of(context)!.everyear +
                          ' ' +
                          _appService.selectedServiceItemData['total_experts']
                              .toString() +
                          ' ' +
                          Languages.of(context)!.peopleTrust +
                          ' ' +
                          _appService.selectedServiceItemData['name'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Colors.black
                              : Colors.white70),
                    ))
                  ],
                ),
                Container(
                  width: 250,
                  margin: EdgeInsets.only(top: 59),
                  child: DefaultButton(
                      text: Languages.of(context)!.get_7,
                      press: () {
                        GoRouter.of(context)
                            .pushNamed(APP_PAGE.hireStep1.toName);
                      }),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  buildImage(img) {
    if (img == null || img.toString().isEmpty)
      return Image.asset(
        'assets/images/placeholder1.png',
        fit: BoxFit.contain,
        width: double.infinity,
        height: double.infinity,
      );
    else
      return ExtendedImage.network(img,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
          compressionRatio: 0.2,
          cache: true,
          clearMemoryCacheIfFailed: true,
          clearMemoryCacheWhenDispose: true);
  }
}
