import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import './service_card.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:localservice/localization/language/languages.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController eCtrl = TextEditingController();

  late AppService appService;
  dynamic serviceDataList = [];

  @override
  void initState() {
    appService = Provider.of<AppService>(context, listen: false);
    appService.selectedSubServiceList = [];
    getSubServiceList();
    super.initState();
  }

  Future<void> getSubServiceList() async {
    for (int i = 0; i < appService.selectedServices.length; i++) {
      final response = await appService.getServiceById(
          serviceID: appService.selectedServices[i]['id']);
      if (response is String || response == null) {
        setState(() {});
      } else {
        if (response.data['sub'] != null && response.data['sub'].length != 0)
          setState(() {
            serviceDataList.add(response.data);
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.watch<AppService>().themeState.isDarkTheme == false
              ? Colors.white
              : context
                  .watch<AppService>()
                  .themeState
                  .customColors[AppColors.primaryBackgroundColor],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 16),
              width: 335,
              child: Text(
                Languages.of(context)!.step2_heading,
                style: TextStyle(
                  fontSize: 32,
                  color: context
                      .watch<AppService>()
                      .themeState
                      .customColors[AppColors.primaryTextColor1],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 15),
              width: 270,
              child: Text(
                Languages.of(context)!.change_anytime,
                style: TextStyle(
                  fontSize: 14,
                  color: context
                      .watch<AppService>()
                      .themeState
                      .customColors[AppColors.primaryTextColor1],
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: serviceDataList.length,
              itemBuilder: (ctx, index) => ServiceCard(
                serviceData: serviceDataList[index],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: DefaultButton(
              text: Languages.of(context)!.next_btn,
              press: () async {
                // if (appService.selectedSubServiceList.length == 0) {
                //   showTopSnackBar(
                //     context,
                //     CustomSnackBar.info(
                //       message: Languages.of(context)!.alert_select_service,
                //     ),
                //   );
                //   return;
                // }
                final response = await appService.setServices();
                if (response is String || response == null) {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message: response,
                    ),
                  );
                } else {
                  GoRouter.of(context).pushNamed(APP_PAGE.workStep3.toName);
                }
              })),
    );
  }
}
