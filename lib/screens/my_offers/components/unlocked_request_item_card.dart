import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:localservice/services/AppService.dart';

class UnlockedrequestItemCard extends StatefulWidget {
  const UnlockedrequestItemCard({required this.index, required this.data});
  final data;
  final index;
  @override
  _UnlockedrequestItemCardState createState() =>
      _UnlockedrequestItemCardState();
}

class _UnlockedrequestItemCardState extends State<UnlockedrequestItemCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: context.watch<AppService>().themeState.isDarkTheme == false
            ? Color.fromARGB(255, 236, 236, 236)
            : Color.fromRGBO(56, 59, 64, 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data['full_name'] +
                    ', ' +
                    (widget.data['city'] == null
                        ? ''
                        : widget.data['city']['name']),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.watch<AppService>().themeState.isDarkTheme ==
                            false
                        ? Colors.black
                        : Color.fromRGBO(217, 217, 217, 1)),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                widget.data['description'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(111, 118, 126, 1)),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Color.fromARGB(255, 107, 107, 107),
                    size: 25,
                  ),
                  SizedBox(width: 4),
                  Text(
                    DateFormat(
                                'EEE, dd  MMMM yyyy',
                                myLocale.countryCode.toString().toLowerCase() ==
                                        "us"
                                    ? "en"
                                    : myLocale.countryCode.toString())
                            .format(DateTime.parse(
                          widget.data['updated_on'],
                        )) +
                        ' - ' +
                        DateFormat.jm(
                                myLocale.countryCode.toString().toLowerCase() ==
                                        "us"
                                    ? "en"
                                    : myLocale.countryCode.toString())
                            .format(DateTime.parse(
                          widget.data['updated_on'],
                        )),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                true
                            ? Colors.white
                            : Color.fromRGBO(79, 162, 219, 1)),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Color.fromRGBO(79, 162, 219, 1),
                    size: 25,
                  ),
                  SizedBox(width: 4),
                  Flexible(
                      child: Text(
                    widget.data['address'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                true
                            ? Colors.white
                            : Color.fromRGBO(79, 162, 219, 1)),
                  )),
                ],
              )
            ],
          )),
          Container(
              width: 30,
              child: Icon(
                Icons.chevron_right,
                color: Color.fromRGBO(79, 162, 219, 1),
                size: 40,
              )),
        ],
      ),
    );
  }
}
