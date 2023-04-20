import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  bool isLoaded = false;
  bool isDeposited = true;
  bool isInvalid = false;
  bool isSuccess = false;
  bool processingPayment = false;
  dynamic stripeData;

  int selectedCardIndex = 0;
  dynamic creditsList;
  var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '9.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    getCreditList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getCreditList() async {
    dynamic response = await _appService.getPlansList();
    if (!mounted) return;

    if (response is String || response == null) {
      creditsList = null;
      setState(() {
        isLoaded = true;
      });
      return;
    }
    setState(() {
      isLoaded = true;
      creditsList = response.data;
      _appService.selectedCredit = creditsList[0];
    });
  }

  Future<void> depositUsingRedeem(redeem) async {
    setState(() {
      isDeposited = false;
    });
    dynamic response =
        await _appService.depositUsingRedeemCode(redeemCode: redeem);
    if (!mounted) return;

    if (response is String || response == null) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: response,
        ),
      );
      setState(() {
        isInvalid = true;
        isSuccess = false;
      });
      return;
    } else {
      if (response.data['message'] == null) {
        //if error
        setState(() {
          isInvalid = true;
          isSuccess = false;
        });
        showTopSnackBar(Overlay.of(context),
            CustomSnackBar.error(message: response.data['error']));
      } else {
        // if success
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(message: response.data['message']),
        );
        setState(() {
          isInvalid = false;
          isSuccess = true;
        });
      }
    }
    setState(() {
      isDeposited = true;
    });
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(15),
              titlePadding: EdgeInsets.all(15),
              content: Form(
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Languages.of(context)!.redeemVoucher,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close))
                        ],
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  if (!isInvalid && !isSuccess)
                    Text(
                      Languages.of(context)!.redeemAction,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  if (isInvalid)
                    Text(
                      Languages.of(context)!.codeInvaild,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(232, 104, 111, 1)),
                    ),
                  if (isSuccess)
                    Text(
                      Languages.of(context)!.couponSuccess,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(19, 138, 9, 1)),
                    ),
                  SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    controller: _textEditingController,
                    validator: (value) {
                      return value!.isNotEmpty
                          ? null
                          : Languages.of(context)!.filedMandatory;
                    },
                    decoration: InputDecoration(
                      label: Text(
                        Languages.of(context)!.cousherCode,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  isDeposited
                      ? DefaultButton(
                          text: isInvalid
                              ? Languages.of(context)!.tryAgain
                              : isSuccess
                                  ? Languages.of(context)!.addNew
                                  : Languages.of(context)!.apply,
                          press: () async {
                            if (isSuccess) {
                              setState(() {
                                isSuccess = false;
                                _textEditingController.text = '';
                              });
                            }
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isDeposited = false;
                              });
                              await depositUsingRedeem(
                                  _textEditingController.text);
                              setState(() {
                                isDeposited = true;
                              });
                            }
                          })
                      : CircularProgressIndicator()
                ]),
              ),
            );
          });
        });
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !isLoaded
            ? Center(child: CircularProgressIndicator())
            : ApplePayButton(
                paymentConfiguration: PaymentConfiguration.fromJsonString('''{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "merchant.com.recomand.app",
    "displayName": "Sam's Fish",
    "merchantCapabilities": ["3DS", "debit", "credit"],
    "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
    "countryCode": "US",
    "currencyCode": "USD",
    "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"],
    "requiredShippingContactFields": [],
    "shippingMethods": [
      {
        "amount": "0.00",
        "detail": "Available within an hour",
        "identifier": "in_store_pickup",
        "label": "In-Store Pickup"
      },
      {
        "amount": "4.99",
        "detail": "5-8 Business Days",
        "identifier": "flat_rate_shipping_id_2",
        "label": "UPS Ground"
      },
      {
        "amount": "29.99",
        "detail": "1-3 Business Days",
        "identifier": "flat_rate_shipping_id_1",
        "label": "FedEx Priority Mail"
      }
    ]
  }
}'''),
                paymentItems: _paymentItems,
                style: ApplePayButtonStyle.black,
                type: ApplePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onApplePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
