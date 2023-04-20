import 'package:flutter/material.dart';
import 'package:localservice/size_config.dart';
import 'package:upgrader/upgrader.dart';
import './components/body.dart';
import '../../components/custom_bottom_navigation_bar.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/localization/language/languages.dart';

// update
class BrowseRequestScreen extends StatelessWidget {
  static const routeName = '/brwose-requests';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return UpgradeAlert(
        upgrader: Upgrader(
          durationUntilAlertAgain: Duration(days: 1),
          dialogStyle: UpgradeDialogStyle.cupertino,
        ),
        child: Scaffold(
          backgroundColor: context
              .watch<AppService>()
              .themeState
              .customColors[AppColors.primaryBackgroundColor],
          body: Body(),
          bottomNavigationBar: CustomBottomNavigationBar(
            selectedMenu: Menu.browseRequests,
          ),
        ));
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
                  hintText: Languages.of(context)!.sendRequest,
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
