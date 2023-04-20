import 'package:flutter/material.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';

// import '../../../size_config.dart';
class CreditCard extends StatefulWidget {
  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  late AppService _appService;
  enumPaymentMethod? currentPayment;
  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    setState(() {
      currentPayment = _appService.currentPaymentMethod;
    });
  }

  @override
  void dispose() {
    //...
    super.dispose();
    //...
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      setState(() {
        if (_appService.paymentMethodList['stripe'] == true)
          currentPayment = _appService.currentPaymentMethod;
        else
          currentPayment = null;
      });
    });

    return InkWell(
        onTap: () {
          setState(() {
            _appService.currentPaymentMethod = enumPaymentMethod.stripe;
            currentPayment = enumPaymentMethod.stripe;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: Border.all(color: Color.fromARGB(255, 224, 224, 224))),
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: 80,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: context.watch<AppService>().themeState.isDarkTheme!
                    ? Image.asset("assets/images/Credit Card_D.png")
                    : Image.asset("assets/images/Credit Card.png"),
              ),
              Expanded(
                flex: 6,
                child: Text(Languages.of(context)!.creditCard),
              ),
              Expanded(
                  flex: 2,
                  child: Radio<enumPaymentMethod>(
                    value: enumPaymentMethod.stripe,
                    groupValue: currentPayment,
                    onChanged: currentPayment == null
                        ? null
                        : (enumPaymentMethod? value) {
                            setState(() {
                              _appService.currentPaymentMethod = value;
                              currentPayment = value;
                            });
                          },
                  )),
            ],
          ),
        ));
  }
}
