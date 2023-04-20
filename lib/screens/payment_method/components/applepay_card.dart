import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';

// import '../../../size_config.dart';
class ApplepayCard extends StatefulWidget {
  @override
  _ApplepayCardState createState() => _ApplepayCardState();
}

class _ApplepayCardState extends State<ApplepayCard> {
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
        if (_appService.paymentMethodList['apple_pay'] == true)
          currentPayment = _appService.currentPaymentMethod;
        else
          currentPayment = null;
      });
    });

    return InkWell(
        onTap: () {
          setState(() {
            _appService.currentPaymentMethod = enumPaymentMethod.apple;
            currentPayment = enumPaymentMethod.apple;
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
                    ? Image.asset("assets/images/Apple Pay_D.png")
                    : Image.asset("assets/images/Apple Pay.png"),
              ),
              Expanded(
                flex: 6,
                child: Text("Apple Pay"),
              ),
              Expanded(
                  flex: 2,
                  child: Radio<enumPaymentMethod>(
                    value: enumPaymentMethod.apple,
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
