import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/services/AppService.dart';

class CreditPlanCard extends StatefulWidget {
  const CreditPlanCard({required this.planItem, required this.isSelected});
  final planItem;
  final isSelected;

  @override
  _CreditPlanCardState createState() => _CreditPlanCardState();
}

class _CreditPlanCardState extends State<CreditPlanCard> {
  bool processingPayment = false;
  dynamic stripeData;
  @override
  void initState() {
    super.initState();
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
