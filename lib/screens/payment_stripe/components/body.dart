import 'package:flutter/material.dart';
import 'dart:async';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:provider/provider.dart';

import 'package:localservice/services/AppService.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  dynamic stripeData;

  bool isLoading = true;

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    newOrderbyStripe();
    // if (!kIsWeb && Platform.isAndroid)
    //   WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  void dispose() {
    //...
    super.dispose();
    //...
  }

  Future<void> newOrderbyStripe() async {
    setState(() {
      isLoading = true;
    });
    dynamic response = await _appService.newOrderStripe(
        plan_id: _appService.selectedCredit['id']);
    if (!mounted) return;

    if (response is String || response == null) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: response,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } else {
      stripeData = response.data;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: LoadingIndicator(
                      indicatorType: Indicator.ballClipRotateMultiple,

                      /// Required, The loading type of the widget
                      colors: [
                        context
                            .watch<AppService>()
                            .themeState
                            .customColors[AppColors.loadingIndicatorColor]!
                      ],

                      /// Optional, The color collections
                      strokeWidth: 2,

                      /// Optional, The stroke of the line, only applicable to widget which contains line
                      backgroundColor: Colors.transparent,

                      /// Optional, Background of the widget
                      pathBackgroundColor:
                          context.watch<AppService>().themeState.customColors[
                              AppColors.loadingIndicatorBackgroundColor]

                      /// Optional, the stroke backgroundColor
                      ),
                ),
                Text(
                  Languages.of(context)!.processing,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ))
        : Scaffold(body: SizedBox());
  }
}
