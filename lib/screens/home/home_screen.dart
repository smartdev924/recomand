import 'package:flutter/material.dart';
import 'package:localservice/size_config.dart';
import 'package:upgrader/upgrader.dart';

import './components/body.dart';
import '../../components/custom_bottom_navigation_bar.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';

// update
class HomeScreen extends StatefulWidget {
  const HomeScreen(
      // key? key,
      );
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppService _appService;
  var appcastURL = 'https://tanzaniasafaricollection.netlify.app/appcast.xml';
  var cfg = null;
  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: context
          .watch<AppService>()
          .themeState
          .customColors[AppColors.primaryBackgroundColor],
      // appBar: appBar(context),
      body: _appService.user == null
          ? Container()
          : UpgradeAlert(
              upgrader: Upgrader(
                durationUntilAlertAgain: Duration(days: 1),
                dialogStyle: UpgradeDialogStyle.cupertino,
              ),
              child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    // These are the slivers that show up in the "outer" scroll view.
                    return <Widget>[
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                          toolbarHeight: 100,
                          backgroundColor: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  true
                              ? Color.fromRGBO(89, 124, 229, 1)
                              : Color.fromRGBO(67, 107, 225, 1),
                          automaticallyImplyLeading: false,
                          title: Container(
                            padding: EdgeInsets.only(
                                left: 0, right: 0, top: 30, bottom: 20),
                            color: context
                                        .watch<AppService>()
                                        .themeState
                                        .isDarkTheme ==
                                    true
                                ? Color.fromRGBO(89, 124, 229, 1)
                                : Color.fromRGBO(67, 107, 225, 1),
                            width: double.infinity,
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _appService.user['full_name'] == null
                                    ? Text(
                                        Languages.of(context)!.hi,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      )
                                    : Text(
                                        Languages.of(context)!.hi +
                                            ', ' +
                                            _appService.user['full_name'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                Container(
                                  margin: EdgeInsets.only(top: 13, bottom: 0),
                                  width: 320,
                                  child: Text(
                                    Languages.of(context)!.home_description,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ), // This is the title in the app bar.
                          pinned: false,
                          expandedHeight: 0.0,

                          forceElevated: innerBoxIsScrolled,
                        ),
                      ),
                    ];
                  },
                  body: MediaQuery.removePadding(
                      context: context, removeTop: true, child: Body()))),
      bottomNavigationBar: CustomBottomNavigationBar(selectedMenu: Menu.home),
    );
  }

  PreferredSize appBar(BuildContext context) {
    final _appService = Provider.of<AppService>(context, listen: false);
    final TextEditingController eCtrl = TextEditingController();
    return PreferredSize(
      child: Container(
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              TextFormField(
                controller: eCtrl,
                validator: (value) {
                  if (value?.isEmpty == false) {
                    if (value != null && value.contains('\n')) {
                      eCtrl.clear(); // Clear the Text area
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        var singleline = value.trim();
                        _appService.setKeywords(singleline);
                        GoRouter.of(context)
                            .pushNamed(APP_PAGE.searchProducts.toName);
                      });
                    }
                  }
                  return null;
                },
                // onChanged: (value) {
                //   // search value 🔍
                // },
                maxLines: null,
                autovalidateMode: AutovalidateMode.always,
                textInputAction: TextInputAction.none,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(1),
                    vertical: getProportionateScreenHeight(19),
                  ),
                  hintText: Languages.of(context)!.searchRequest,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }
}
