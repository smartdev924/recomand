import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:intl/intl.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyJobsItemCard extends StatefulWidget {
  const MyJobsItemCard(
      {required this.index, required this.data, required this.is_active});
  final data;
  final index;
  final is_active;
  @override
  _MyJobsItemCardState createState() => _MyJobsItemCardState();
}

class _MyJobsItemCardState extends State<MyJobsItemCard> {
  late AppService _appService;
  late String cancelReason = '1';

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    super.initState();
  }

  showAlertDialog(
    BuildContext context,
  ) {
    final _appService = Provider.of<AppService>(context, listen: false);
    Widget cancelButton = TextButton(
      child: Text(Languages.of(context)!.cancel_btn),
      onPressed: () {
        Navigator.pop(context, Languages.of(context)!.cancel_btn);
      },
    );
    Widget continueButton = TextButton(
      child: Text(Languages.of(context)!.confirm),
      onPressed: () async {
        dynamic response = await _appService.cancelRequestById(
            requestID: widget.data['id'], reason: int.parse(cancelReason));
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
              message: Languages.of(context)!.canceledRequest,
            ),
          );
        Navigator.pop(context, 'Ok');
      },
    ); // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      title: Text(
        Languages.of(context)!.pleaseSelectReason,
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
                  title: Text(Languages.of(context)!.cancelRequestReason1),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "2",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.cancelRequestReason2),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "3",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.cancelRequestReason3),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "4",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.cancelRequestReason4),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "5",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.cancelRequestReason5),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "6",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.cancelRequestReason6),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  })
            ]);
      }),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _onMenuItemSelected(int value, BuildContext context) {
    setState(() {
      // _popupMenuItemIndex = value;
    });

    if (value == 1) {
      _appService.selectedJobData = widget.data;
      _appService.isFromBrowser = false;
      GoRouter.of(context).pushNamed(APP_PAGE.jobDetails.toName);
    }
    if (value == 2) {
      showAlertDialog(context);
    }
    if (value == 3) {
      _appService.selectedJobData = widget.data;
      GoRouter.of(context).pushNamed(APP_PAGE.myJobOffers.toName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Stack(children: [
          Container(
              margin: EdgeInsets.only(bottom: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: context.watch<AppService>().themeState.isDarkTheme ==
                          false
                      ? Colors.white
                      : Colors.black87,
                  borderRadius: BorderRadius.circular(3.0),
                  border: Border.all(
                      width: 1,
                      color:
                          context.watch<AppService>().themeState.isDarkTheme ==
                                  false
                              ? Color.fromRGBO(218, 218, 218, 1)
                              : Colors.black87)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromRGBO(217, 217, 217, 0.3)),
                    )),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('dd MMMM yyyy').format(
                              DateTime.parse(widget.data['updated_on'])),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(137, 138, 143, 1)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.data['service']['name'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: context
                                        .watch<AppService>()
                                        .themeState
                                        .isDarkTheme ==
                                    false
                                ? Color.fromRGBO(217, 217, 217, 1)
                                : Color.fromRGBO(51, 51, 51, 1),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Text(
                              widget.is_active
                                  ? Languages.of(context)!.active.toUpperCase()
                                  : Languages.of(context)!
                                      .Cancelled
                                      .toUpperCase(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: context
                                            .watch<AppService>()
                                            .themeState
                                            .isDarkTheme ==
                                        false
                                    ? Colors.black
                                    : widget.is_active
                                        ? Color.fromRGBO(79, 162, 219, 1)
                                        : Color.fromRGBO(232, 104, 111, 1),
                              )),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                  Languages.of(context)!.totalProposal +
                                      " : " +
                                      widget.data['total_proporsal'].toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: context
                                                  .watch<AppService>()
                                                  .themeState
                                                  .isDarkTheme ==
                                              false
                                          ? Colors.black
                                          : Color.fromRGBO(79, 162, 219, 1)))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
          widget.is_active
              ? Positioned(
                  top: 5,
                  right: 5,
                  child: PopupMenuButton(
                      onSelected: (value) {
                        _onMenuItemSelected(value as int, context);
                      },
                      // initialValue: 2,
                      child: Icon(
                        Icons.more_vert,
                        color: context
                            .watch<AppService>()
                            .themeState
                            .customColors[AppColors.primaryTextColor1],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Text(
                                Languages.of(context)!.see_details,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: context
                                            .watch<AppService>()
                                            .themeState
                                            .customColors[
                                        AppColors.primaryTextColor1]),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text(Languages.of(context)!.pauseReq,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: context
                                              .watch<AppService>()
                                              .themeState
                                              .customColors[
                                          AppColors.primaryTextColor1])),
                            ),
                            PopupMenuItem(
                              value: 3,
                              child: Text(Languages.of(context)!.viewOffers,
                                  style: TextStyle(
                                      color: context
                                              .watch<AppService>()
                                              .themeState
                                              .customColors[
                                          AppColors.primaryTextColor1]),
                                  textAlign: TextAlign.center),
                            )
                          ]),
                )
              : Container()
        ]),
        onTap: () {
          _appService.selectedJobData = widget.data;
          _appService.isFromBrowser = false;
          GoRouter.of(context).pushNamed(APP_PAGE.myJobOffers.toName);
        });
  }
}
