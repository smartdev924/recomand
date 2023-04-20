import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:localservice/services/AppService.dart';

class RequestItemCard extends StatefulWidget {
  const RequestItemCard({required this.index, required this.data});
  final data;
  final index;
  @override
  _RequestItemCardState createState() => _RequestItemCardState();
}

class _RequestItemCardState extends State<RequestItemCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: context.watch<AppService>().themeState.isDarkTheme == false
                ? Color.fromARGB(255, 240, 240, 240)
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
                        (widget.data['service'] == null
                            ? ''
                            : widget.data['service']['name']),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                false
                            ? Colors.black
                            : Color.fromRGBO(79, 162, 219, 1)),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.data['description'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(137, 138, 143, 1)),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined,
                          color: Color.fromARGB(255, 180, 180, 180), size: 25),
                      SizedBox(width: 4),
                      Text(
                        DateFormat(
                                    'EEE, dd  MMMM yyyy',
                                    myLocale.countryCode
                                                .toString()
                                                .toLowerCase() ==
                                            "us"
                                        ? "en"
                                        : myLocale.countryCode.toString())
                                .format(DateTime.parse(
                              widget.data['updated_on'],
                            )) +
                            ' - ' +
                            DateFormat.jm(myLocale.countryCode
                                            .toString()
                                            .toLowerCase() ==
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
                          widget.data['address'] == null
                              ? Icons.location_off_outlined
                              : Icons.location_on_outlined,
                          color: Color.fromARGB(255, 107, 107, 107),
                          size: 25),
                      SizedBox(width: 4),
                      if (widget.data['address'] != null)
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                      width: 30,
                      child: Icon(
                        Icons.chevron_right,
                        color: Color.fromRGBO(79, 162, 219, 1),
                        size: 50,
                      )),
                  SizedBox(
                    height: 10,
                  )
                ],
              )
            ],
          ),
        ),
        if (widget.data['priority'] == "HIGH")
          Positioned(
            top: 20,
            right: 10,
            child: SizedBox(
                width: 30,
                child: Icon(
                  Icons.timer,
                  color: Color.fromRGBO(255, 118, 76, 1),
                  size: 25,
                )),
          ),
        Positioned(
            bottom: 10,
            right: 10,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: context.watch<AppService>().themeState.isDarkTheme ==
                            true
                        ? Color.fromARGB(255, 95, 95, 95)
                        : Color.fromARGB(255, 182, 182, 182)),
                width: 28,
                height: 28,
                alignment: Alignment.center,
                child: Text(
                  widget.data['total_proporsal'].toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(43, 44, 46, 1)),
                ))),
      ],
    );
  }
}
