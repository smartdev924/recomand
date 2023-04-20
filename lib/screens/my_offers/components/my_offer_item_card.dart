import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/dotted_seperator.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:intl/intl.dart';

class MyOfferItemCard extends StatefulWidget {
  const MyOfferItemCard({required this.data});
  final data;

  @override
  _MyOfferItemCardState createState() => _MyOfferItemCardState();
}

class _MyOfferItemCardState extends State<MyOfferItemCard> {
  late AppService _appService;
  bool _customTileExpanded = false;
  late String cancelReason = '1';

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    super.initState();
  }

  _onMenuItemSelected(int value, BuildContext context) async {
    setState(() {});

    if (value == 1) {
      dynamic response = await _appService.getRequestById(
          requestID: widget.data['request_id']);
      if (response == null || response is String) {
        return;
      }
      _appService.selectedJobData = response.data;
      _appService.selectedOfferToUpdate = widget.data;
      GoRouter.of(context).pushNamed(APP_PAGE.updateOffer.toName);
    }
  }

  showAlertDialog(
    BuildContext context,
  ) {
    final _appService = Provider.of<AppService>(context, listen: false);

    Widget cancelButton = TextButton(
      child: Text(Languages.of(context)!.cancel_btn),
      onPressed: () {
        Navigator.pop(context, 'Cancel');
      },
    );
    Widget continueButton = TextButton(
      child: Text(Languages.of(context)!.confirm),
      onPressed: () async {
        dynamic response = await _appService.cancelOfferById(
            offerID: widget.data['id'], reason: int.parse(cancelReason));
        if (response is String || response == null)
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: response,
            ),
          );
        else
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message: Languages.of(context)!.cancelledOffer,
            ),
          );
        Navigator.pop(context, 'Ok');
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        Languages.of(context)!.reasonSelect,
        textAlign: TextAlign.center,
      ),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RadioListTile(
                  value: "1",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.c_reason_1),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "2",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.c_reason_2),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "3",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.c_reason_3),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "4",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.c_reason_4),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "5",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.c_reason_5),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
            ]);
      }),
      actions: [
        cancelButton,
        continueButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return GestureDetector(
        onTap: () async {
          _appService.isFromBrowser = false;
          _appService.fromPushNotification = false;
          _appService.selectedOfferToUpdate = widget.data;

          GoRouter.of(context).pushNamed(APP_PAGE.directJobDetails.toName,
              params: {"requestID": widget.data['request_id'].toString()});
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color:
                    context.watch<AppService>().themeState.isDarkTheme == true
                        ? Color.fromRGBO(44, 44, 44, 1)
                        : Color.fromRGBO(202, 202, 202, 1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: context.watch<AppService>().themeState.isDarkTheme == false
                  ? Colors.white
                  : Color.fromRGBO(13, 13, 13, 1),
              boxShadow: <BoxShadow>[
                if (context.watch<AppService>().themeState.isDarkTheme == true)
                  BoxShadow(
                      color: Color.fromRGBO(44, 44, 44, 1),
                      blurRadius: 2.0,
                      offset: Offset(0, 2))
              ],
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(Icons.account_box,
                                color: Color.fromRGBO(137, 138, 143, 1)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.data['customer']['full_name'] == null
                                  ? ""
                                  : widget.data['customer']['full_name'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(137, 138, 143, 1)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Icon(Icons.calendar_month_outlined,
                              color: Color.fromRGBO(137, 138, 143, 1)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateFormat(
                                        'dd.MM.yyyy',
                                        myLocale.countryCode
                                                    .toString()
                                                    .toLowerCase() ==
                                                "us"
                                            ? "en"
                                            : myLocale.countryCode.toString())
                                    .format(DateTime.parse(
                                  widget.data['updated_on'],
                                )) +
                                ',  ' +
                                DateFormat.jm(myLocale.countryCode
                                                .toString()
                                                .toLowerCase() ==
                                            "us"
                                        ? "en"
                                        : myLocale.countryCode.toString())
                                    .format(DateTime.parse(
                                  widget.data['updated_on'],
                                )),

                            // widget.data['updated_on'],
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(79, 162, 219, 1)),
                          ),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () async {
                                  if (widget.data['customer']['phone'] != null)
                                    await FlutterPhoneDirectCaller.callNumber(
                                        widget.data['customer']['phone']);
                                },
                                child: Icon(Icons.phone,
                                    color: Color.fromRGBO(137, 138, 143, 1))),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () async {
                                  if (widget.data['customer']['phone'] != null)
                                    await FlutterPhoneDirectCaller.callNumber(
                                        widget.data['customer']['phone']);
                                },
                                child: Text(
                                  widget.data['customer']['phone'] == null
                                      ? ""
                                      : widget.data['customer']['phone'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(137, 138, 143, 1)),
                                )),
                          ],
                        ),
                      ],
                    )),
                    Container(
                        width: 20,
                        child: PopupMenuButton(
                            onSelected: (value) {
                              _onMenuItemSelected(value as int, context);
                            },
                            // initialValue: 2,
                            child: Icon(Icons.more_vert),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: Text(
                                      Languages.of(context)!.update_offer,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  // PopupMenuItem(
                                  //   value: 2,
                                  //   child: Text("Cancel Offer",
                                  //       textAlign: TextAlign.center),
                                  // )
                                ])),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    MySeparator(
                      color:
                          context.watch<AppService>().themeState.isDarkTheme ==
                                  false
                              ? Color.fromRGBO(224, 224, 224, 1)
                              : Color.fromRGBO(137, 138, 143, 1),
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            _customTileExpanded = !_customTileExpanded;
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: context
                                            .watch<AppService>()
                                            .themeState
                                            .isDarkTheme ==
                                        false
                                    ? Color.fromRGBO(224, 224, 224, 1)
                                    : Color.fromRGBO(137, 138, 143, 1),
                              ),
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Colors.white
                                  : Colors.black87,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(
                              _customTileExpanded
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                            ))),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                if (_customTileExpanded)
                  Text(
                    widget.data['description'],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                false
                            ? Colors.black87
                            : Color.fromRGBO(111, 118, 126, 1)),
                  ),
                if (_customTileExpanded)
                  SizedBox(
                    height: 15,
                  ),
                if (_customTileExpanded)
                  MySeparator(
                    color: Color.fromRGBO(224, 224, 224, 1),
                  ),
                SizedBox(
                  height: 15,
                ),
                if (widget.data['available_from'] != null &&
                    widget.data['available_from'].toString().toLowerCase() !=
                        'null')
                  Row(
                    children: [
                      context.watch<AppService>().themeState.isDarkTheme ==
                              false
                          ? Image.asset(
                              'assets/images/start.png',
                              fit: BoxFit.cover,
                              width: 20,
                              // height: double.infinity,
                            )
                          : Image.asset(
                              'assets/images/start_dark.png',
                              fit: BoxFit.cover,
                              width: 20,
                              // height: double.infinity,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Languages.of(context)!.startFrom +
                            ' : ' +
                            DateFormat('dd/MM/yyyy').format(
                                DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'')
                                    .parse(widget.data['available_from'])),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(137, 138, 143, 1)),
                      )
                    ],
                  ),
                if (widget.data['dead_line'] != null &&
                    widget.data['dead_line'].toString().toLowerCase() != 'null')
                  SizedBox(
                    height: 15,
                  ),
                if (widget.data['dead_line'] != null &&
                    widget.data['dead_line'].toString().toLowerCase() != "null")
                  Row(
                    children: [
                      context.watch<AppService>().themeState.isDarkTheme ==
                              false
                          ? Image.asset(
                              'assets/images/deadline.png',
                              fit: BoxFit.cover,
                              width: 20,
                              // height: double.infinity,
                            )
                          : Image.asset(
                              'assets/images/end_dark.png',
                              fit: BoxFit.cover,
                              width: 20,
                              // height: double.infinity,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Languages.of(context)!.deadline +
                            ':  ' +
                            widget.data['dead_line'].toString() +
                            ' ' +
                            (widget.data['offer_type'] == null ||
                                    widget.data['offer_type'].toString() ==
                                        'null'
                                ? ""
                                : widget.data['offer_type'].toUpperCase()),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(137, 138, 143, 1)),
                      )
                    ],
                  ),
                if (widget.data['dead_line'] != null &&
                    widget.data['dead_line'].toString().toLowerCase() != "null")
                  SizedBox(
                    width: 10,
                  ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    context.watch<AppService>().themeState.isDarkTheme == false
                        ? Image.asset(
                            'assets/images/offer_sm.png',
                            fit: BoxFit.cover,
                            width: 17,

                            // height: double.infinity,
                          )
                        : Image.asset(
                            'assets/images/offer_sm.png',
                            fit: BoxFit.cover,
                            width: 17,
                            color: Colors.white70,

                            // height: double.infinity,
                          ),
                    SizedBox(
                      width: 13,
                    ),
                    Text(
                      Languages.of(context)!.offer +
                          ' : ' +
                          widget.data['price'].toString() +
                          " " +
                          (widget.data['currency_type'] == null
                              ? ""
                              : widget.data['currency_type']),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(137, 138, 143, 1)),
                    )
                  ],
                )
              ],
            )));
  }
}
