import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:localservice/screens/my_job_offers/components/job_offer_item_card.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  bool isLoaded = false;
  dynamic myJobOfferList;

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    getJobOffersList();
  }

  Future<void> getJobOffersList() async {
    dynamic response = await _appService.getOffersById(
        requestID: _appService.selectedJobData['id']);
    if (!mounted) return;

    if (response is String || response == null) {
      myJobOfferList = [];
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: response,
        ),
      );
      setState(() {
        isLoaded = true;
      });
      return;
    }

    myJobOfferList = response.data['data'];

    // selectedDate = formatter.parse(widget.notiItem['created_on']);
    setState(() {
      isLoaded = true;
    });
  }

  // ignore: unused_field
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return SafeArea(
        child: Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Color.fromRGBO(137, 138, 143, 0.5),
              ),
              color: context.watch<AppService>().themeState.isDarkTheme == false
                  ? Color.fromRGBO(249, 249, 255, 1)
                  : Colors.black87,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _appService.selectedJobData['city'] != null
                          ? _appService.selectedJobData['service']['name'] +
                              ', ' +
                              _appService.selectedJobData['city']['name']
                          : _appService.selectedJobData['service']['name'],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Color.fromRGBO(57, 58, 60, 1)
                              : Color.fromRGBO(209, 210, 212, 1)),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
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
                                _appService.selectedJobData['updated_on'],
                              )) +
                              ',  ' +
                              DateFormat.jm(myLocale.countryCode
                                              .toString()
                                              .toLowerCase() ==
                                          "us"
                                      ? "en"
                                      : myLocale.countryCode.toString())
                                  .format(DateTime.parse(
                                _appService.selectedJobData['updated_on'],
                              )) +
                              ' | ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(136, 140, 155, 1)
                                  : Color.fromRGBO(151, 151, 151, 1)),
                        ),
                        Text(
                          Languages.of(context)!.totalProposal +
                              ' : ' +
                              _appService.selectedJobData['total_proporsal']
                                  .toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Color.fromRGBO(136, 140, 155, 1)
                                  : Color.fromRGBO(151, 151, 151, 1)),
                        )
                      ],
                    )
                  ],
                )),
                Text(
                  '#' + _appService.selectedJobData['id'].toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color:
                          context.watch<AppService>().themeState.isDarkTheme ==
                                  false
                              ? Color.fromRGBO(136, 140, 155, 1)
                              : Color.fromRGBO(151, 151, 151, 1)),
                ),
              ],
            )),
        Expanded(
          child: isLoaded
              ? myJobOfferList.length != 0
                  ? SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: myJobOfferList.length,
                          itemBuilder: (ctx, index) =>
                              JobOfferItemCard(data: myJobOfferList[index])))
                  : Center(
                      child: Text(Languages.of(context)!.no_proposal),
                    )
              : Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(79, 162, 219, 1),
                  ),
                ),
        )
      ],
    ));
  }
}
