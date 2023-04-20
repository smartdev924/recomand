import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';

class BitcoinCard extends StatefulWidget {
  @override
  _BitcoinCardState createState() => _BitcoinCardState();
}

class _BitcoinCardState extends State<BitcoinCard> {
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
        if (_appService.paymentMethodList['bitcoin'] == true)
          currentPayment = _appService.currentPaymentMethod;
        else
          currentPayment = null;
      });
    });

    return InkWell(
        onTap: () {
          setState(() {
            _appService.currentPaymentMethod = enumPaymentMethod.bitcoin;
            currentPayment = enumPaymentMethod.bitcoin;
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
                child: Image.asset("assets/images/btcpay.png"),
                // child: themeState.isDarkTheme!
                //     ? Image.asset("assets/images/Credit Card_D.png")
                //     : Image.asset("assets/images/btcpay.png"),
              ),
              Expanded(
                flex: 6,
                child: Text("Bitcoin"),
              ),
              Expanded(
                  flex: 2,
                  child: Radio<enumPaymentMethod>(
                    value: enumPaymentMethod.bitcoin,
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
