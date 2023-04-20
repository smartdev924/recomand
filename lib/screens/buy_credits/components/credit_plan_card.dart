import 'package:flutter/material.dart';
import 'package:localservice/services/AppService.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditPlanCard extends StatefulWidget {
  const CreditPlanCard({required this.planItem, required this.isSelected});
  final planItem;
  final isSelected;

  @override
  _CreditPlanCardState createState() => _CreditPlanCardState();
}

class _CreditPlanCardState extends State<CreditPlanCard> {
  late AppService _appService;
  bool processingPayment = false;
  dynamic stripeData;
  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    super.initState();
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
    return Container(
      padding: EdgeInsets.all(13),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: !widget.isSelected
            ? context.watch<AppService>().themeState.isDarkTheme == false
                ? Color.fromRGBO(217, 217, 217, 1)
                : Color.fromRGBO(51, 51, 51, 1)
            : context.watch<AppService>().themeState.isDarkTheme == false
                ? Color.fromRGBO(181, 228, 202, 1)
                : Color.fromRGBO(79, 162, 219, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      // child: InkWell(
      // onTap: () {
      //   if (!widget.isSelected) return;
      //   _appService.currentPaymentMethod = enumPaymentMethod.stripe;
      //   newOrderbyStripe();
      // },
      child: Row(
        children: [
          Image.asset(
            'assets/images/credit.png',
            fit: BoxFit.cover,
            width: 38,
            color: context.watch<AppService>().themeState.isDarkTheme == false
                ? Colors.black87
                : Colors.white,
          ),
          SizedBox(
            width: 19,
          ),
          Text(
            widget.planItem['total_credits'].toString(),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:
                    context.watch<AppService>().themeState.isDarkTheme == false
                        ? Color.fromRGBO(43, 44, 46, 1)
                        : Colors.white70),
          ),
          Expanded(
            child: Container(),
          ),
          if (widget.isSelected)
            Image.asset(
              'assets/images/buy_credits.png',
              fit: BoxFit.cover,
              width: 40,
            ),
          Expanded(
            child: Container(),
          ),
          Text(
            widget.planItem['currency'].toUpperCase() +
                ' ' +
                widget.planItem['price'].toString(),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color:
                    context.watch<AppService>().themeState.isDarkTheme == false
                        ? Color.fromRGBO(43, 44, 46, 1)
                        : Colors.white70),
          ),
          SizedBox(
            width: 21,
          ),
          !widget.isSelected
              ? Image.asset(
                  'assets/images/cart.png',
                  fit: BoxFit.cover,
                  color: context.watch<AppService>().themeState.isDarkTheme ==
                          false
                      ? Colors.black87
                      : Colors.white,
                  width: 28,
                )
              : Image.asset(
                  'assets/images/cart.png',
                  fit: BoxFit.cover,
                  width: 28,
                  color: context.watch<AppService>().themeState.isDarkTheme ==
                          false
                      ? Colors.black87
                      : Colors.white,
                ),
        ],
      ),
      // ),
    );
  }
}
