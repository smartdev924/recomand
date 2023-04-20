import 'package:flutter/material.dart';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/screens/payment_method/components/bank_card.dart';
import 'package:localservice/screens/payment_method/components/googlepay_card.dart';
import 'package:provider/provider.dart';
import 'package:localservice/components/price_button.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../size_config.dart';
import './paypal_card.dart';
import './applepay_card.dart';
import './credit_card.dart';
import './bitcoin_card.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  dynamic methodObj;
  dynamic stripeData;
  dynamic bitPayData;
  bool processingPayment = false;

  bool isLoading = true;

  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    getPaymentMethod();
    super.initState();
  }

  @override
  void dispose() {
    //...
    super.dispose();
    //...
  }

  Future<void> getPaymentMethod() async {
    dynamic response = await _appService.getPyamentMethods(
        plan_id: _appService.selectedCredit['id']);
    if (!mounted) return;

    if (response is String || response == null) {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        methodObj = response.data;
        _appService.paymentMethodList = methodObj;
      });
    }
  }

  Future<void> newOrderbyStripe() async {
    setState(() {
      processingPayment = true;
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
        processingPayment = false;
      });
    } else {
      setState(() {
        processingPayment = false;
      });
      stripeData = response.data;

      if (await canLaunchUrl(Uri.parse(stripeData['invoice_url'])))
        await launchUrl(Uri.parse(stripeData['invoice_url']));
      else
        throw "Could not launch this url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: isLoading
            ? Center(
                child: Container(
                width: 100,
                child: LoadingIndicator(
                    indicatorType: Indicator.circleStrokeSpin,
                    colors: [
                      context
                          .watch<AppService>()
                          .themeState
                          .customColors[AppColors.loadingIndicatorColor]!
                    ],
                    strokeWidth: 2,

                    /// Optional, The stroke of the line, only applicable to widget which contains line
                    backgroundColor: Colors.transparent,

                    /// Optional, Background of the widget
                    pathBackgroundColor: context
                        .watch<AppService>()
                        .themeState
                        .customColors[AppColors.loadingIndicatorBackgroundColor]

                    /// Optional, the stroke backgroundColor
                    ),
              ))
            : Column(children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  if (methodObj['bitcoin'])
                    SizedBox(height: getProportionateScreenHeight(10)),
                  if (methodObj['bitcoin']) BitcoinCard(),
                  if (methodObj['stripe'])
                    SizedBox(height: getProportionateScreenHeight(10)),
                  if (methodObj['stripe']) CreditCard(),
                  if (methodObj['paypal'])
                    SizedBox(height: getProportionateScreenHeight(10)),
                  if (methodObj['paypal']) PaypalCard(),
                  if (methodObj['apple_pay'])
                    SizedBox(height: getProportionateScreenHeight(10)),
                  if (methodObj['apple_pay']) ApplepayCard(),
                  if (methodObj['google_pay'])
                    SizedBox(height: getProportionateScreenHeight(10)),
                  if (methodObj['google_pay']) GooglePayCardCard(),
                  if (methodObj['bank'])
                    SizedBox(height: getProportionateScreenHeight(10)),
                  if (methodObj['bank']) BankCard(),
                ]))),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: processingPayment == false
                      ? PriceButton(
                          text: Languages.of(context)!.payNow,
                          price: _appService.selectedCredit['currency']
                                  .toUpperCase() +
                              ' ' +
                              _appService.selectedCredit['price'].toString(),
                          press: () async {
                            if (!kIsWeb) {
                              if (Platform.isAndroid || Platform.isIOS) {
                                if (_appService.currentPaymentMethod ==
                                    enumPaymentMethod.stripe) {
                                  GoRouter.of(context)
                                      .pushNamed(APP_PAGE.paymentStripe.toName);
                                }
                              } else {
                                if (_appService.currentPaymentMethod ==
                                    enumPaymentMethod.stripe) {
                                  await newOrderbyStripe();
                                }
                              }
                            } else {
                              if (_appService.currentPaymentMethod ==
                                  enumPaymentMethod.stripe) {
                                await newOrderbyStripe();
                              }
                            }
                          },
                        )
                      : CircularProgressIndicator(),
                )
              ]),
      ),
    );
  }
}
