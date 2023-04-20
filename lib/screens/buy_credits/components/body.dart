import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/screens/buy_credits/components/credit_plan_card.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    getCreditList();
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
        await launchUrl(
          Uri.parse(stripeData['invoice_url']),
          mode: LaunchMode.externalApplication,
        );
      else
        throw "Could not launch this url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoaded
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RefreshIndicator(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: creditsList.length,
                                itemBuilder: (ctx, index) => InkWell(
                                    onTap: () {
                                      _appService.selectedCredit =
                                          creditsList[index];
                                      _appService.currentPaymentMethod =
                                          enumPaymentMethod.stripe;
                                      if (selectedCardIndex == index) {
                                        _appService.currentPaymentMethod =
                                            enumPaymentMethod.stripe;
                                        newOrderbyStripe();
                                      } else {
                                        setState(() {
                                          selectedCardIndex = index;
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: CreditPlanCard(
                                          planItem: creditsList[index],
                                          isSelected:
                                              selectedCardIndex == index),
                                    ))),
                            onRefresh: () {
                              return getCreditList();
                            })
                      ]))),
      bottomNavigationBar: InkWell(
        onTap: () {
          _textEditingController.text = '';
          setState(() {
            isInvalid = false;
            isSuccess = false;
          });
          showInformationDialog(context);
        },
        child: Container(
          padding: EdgeInsets.all(20),
          child: Text(
            Languages.of(context)!.haveRedeemCode,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(79, 162, 219, 1),
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
