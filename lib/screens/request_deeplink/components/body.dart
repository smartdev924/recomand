import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/cubit/theme_module/provider/theme_cubit.dart';
import 'package:localservice/cubit/theme_module/states/change_theme_states.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/screens/job_details/components/full_photo.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/size_config.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
  final String requestID;
  Body({
    required this.requestID,
  });
}

class _BodyState extends State<Body> {
  late AppService _appService;
  bool isLoaded = false;
  dynamic myJobList;
  String joinedAgo = '';
  bool loadingJob = false;
  late String cancelReason = '1';

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
            requestID: _appService.selectedJobData['id'],
            reason: int.parse(cancelReason));
        if (response is String || response == null)
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: response,
            ),
          );
        else
          GoRouter.of(context).pushNamed(APP_PAGE.myJobs.toName);
      },
    );

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
                  title: Text(Languages.of(context)!.reason_1),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "2",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.reason_2),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "3",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.reason_3),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "4",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.reason_4),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "5",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.reason_5),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value.toString();
                    });
                  }),
              RadioListTile(
                  value: "6",
                  groupValue: cancelReason,
                  title: Text(Languages.of(context)!.reason_6),
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
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String displayTimeAgoFromTimestamp(String timestamp) {
    final formatter = DateFormat('EEE, d MMM yyyy HH:mm:ss');
    final dateTime = formatter.parse(timestamp);
    String data = daysBetween(dateTime, DateTime.now()).toString();
    if (!mounted) return '';
    setState(() {
      joinedAgo = data;
    });
    return data;
  }

  String daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    var difference = to.difference(from).inHours;
    var differenceMin = to.difference(from).inMinutes;
    if (difference < 24) {
      if (difference < 1) {
        if (differenceMin != 0)
          return Languages.of(context)!.headStringRegistered +
              ' ' +
              differenceMin.toString() +
              ' ' +
              Languages.of(context)!.minutes +
              ' ' +
              Languages.of(context)!.tailStringRegistered;
        else
          Languages.of(context)!.headStringRegistered +
              ' ' +
              differenceMin.toString() +
              ' ' +
              '1' +
              ' ' +
              Languages.of(context)!.tailStringRegistered;
      } else
        return Languages.of(context)!.headStringRegistered +
            ' ' +
            difference.round().toString() +
            ' ' +
            Languages.of(context)!.hours +
            ' ' +
            Languages.of(context)!.tailStringRegistered;
    }
    if ((difference / 24) >= 1 && (difference / 24) < 2)
      return Languages.of(context)!.headStringRegistered +
          ' ' +
          (difference / 24).round().toString() +
          ' ' +
          Languages.of(context)!.day +
          ' ' +
          Languages.of(context)!.tailStringRegistered;
    if ((difference / 24) > 2 && (difference / 24) < 30)
      return Languages.of(context)!.headStringRegistered +
          ' ' +
          (difference / 24).round().toString() +
          ' ' +
          Languages.of(context)!.days +
          ' ' +
          Languages.of(context)!.tailStringRegistered;
    if ((difference / 24) > 30 && (difference / 24) < 60) {
      return Languages.of(context)!.headStringRegistered +
          ' ' +
          (difference / 720).round().toString() +
          ' ' +
          Languages.of(context)!.month +
          ' ' +
          Languages.of(context)!.tailStringRegistered;
    }
    if ((difference / 24) > 60)
      return Languages.of(context)!.headStringRegistered +
          ' ' +
          (difference / 720).round().toString() +
          ' ' +
          Languages.of(context)!.months +
          ' ' +
          Languages.of(context)!.tailStringRegistered;
    return "";
  }

  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  _onMenuItemSelected(int value, BuildContext context) {
    setState(() {});

    if (value == 2) {
      showAlertDialog(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    getJobDataByID();
  }

  Future<void> getJobDataByID() async {
    dynamic response = await _appService.getRequestById(
        requestID: int.parse(widget.requestID));
    if (!mounted) return;

    if (response is String || response == null) {
      _appService.selectedJobData = null;
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
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: response.data['have_offers'].toString(),
      ),
    );
    setState(() {
      isLoaded = true;
    });
    // _appService.isFromBrowser = true;
    _appService.selectedJobData = response.data;
  }

  showUnlockConfirmDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(Languages.of(context)!.cancel_btn),
      onPressed: () {
        Navigator.pop(context, Languages.of(context)!.cancel_btn);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {
        dynamic response = await _appService.unlockRequestById(
            requestID: _appService.selectedJobData['id']);
        if (response is String || response == null) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: response,
            ),
          );
        } else {
          dynamic res = await _appService.getRequestById(
              requestID: _appService.selectedJobData['id']);
          if (res is String || res == null) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: response,
              ),
            );
          } else {
            setState(
              () {
                _appService.selectedJobData = res.data;
              },
            );
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(
                message: Languages.of(context)!.unlockedReq,
              ),
            );
          }
        }
        Navigator.pop(context, 'Cancel');
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Languages.of(context)!.sureUnlock),
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
    Widget image_carousel = new Container();

    if (_appService.selectedJobData != null &&
        _appService.selectedJobData['files'] != null &&
        _appService.selectedJobData['files'].length != 0)
      image_carousel = new Container(
          height: 345.0,
          child: CarouselSlider(
            // height: 400.0,
            options: CarouselOptions(enableInfiniteScroll: false),
            items: _appService.selectedJobData['files'].map<Widget>((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: GestureDetector(
                          child: Image.network(i['link'], fit: BoxFit.fill),
                          onTap: () {
                            Navigator.push<Widget>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageScreen(i['link'],
                                    _appService.selectedJobData['files']),
                              ),
                            );
                          }));
                },
              );
            }).toList(),
          ));
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
        bloc: changeThemeCubit,
        builder: (context, themeState) {
          Locale myLocale = Localizations.localeOf(context);
          return !isLoaded
              ? SizedBox()
              : Scaffold(
                  backgroundColor: themeState.isDarkTheme == false
                      ? Colors.grey[50]
                      : Color.fromRGBO(43, 44, 46, 1),
                  appBar: appBar(context, themeState),
                  body: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: themeState.isDarkTheme == true
                                      ? Color.fromRGBO(56, 59, 64, 1)
                                      : Color.fromARGB(255, 233, 233, 233)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _appService.selectedJobData['full_name'],
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: themeState.isDarkTheme == true
                                            ? Color.fromRGBO(212, 212, 212, 1)
                                            : Color.fromARGB(255, 54, 54, 54)),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month_outlined,
                                          color: themeState.isDarkTheme == true
                                              ? Color.fromRGBO(212, 212, 212, 1)
                                              : Color.fromARGB(
                                                  255, 54, 54, 54)),
                                      SizedBox(width: 10),
                                      Text(
                                        DateFormat.yMMMMd(myLocale.countryCode
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "us"
                                                ? "en"
                                                : myLocale.countryCode
                                                    .toString())
                                            .add_jm()
                                            .format(DateTime.parse(
                                              _appService.selectedJobData[
                                                  'updated_on'],
                                            )),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                themeState.isDarkTheme == true
                                                    ? Color.fromRGBO(
                                                        212, 212, 212, 1)
                                                    : Color.fromARGB(
                                                        255, 54, 54, 54),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 13),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                          color: themeState.isDarkTheme == true
                                              ? Color.fromRGBO(212, 212, 212, 1)
                                              : Color.fromARGB(
                                                  255, 54, 54, 54)),
                                      SizedBox(width: 10),
                                      Flexible(
                                          child: Text(
                                        _appService.selectedJobData[
                                                    'address'] ==
                                                null
                                            ? Languages.of(context)!
                                                .no_city_info
                                            : _appService
                                                .selectedJobData['address'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                themeState.isDarkTheme == true
                                                    ? Color.fromRGBO(
                                                        212, 212, 212, 1)
                                                    : Color.fromARGB(
                                                        255, 54, 54, 54),
                                            fontWeight: FontWeight.w400),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 13),
                                  InkWell(
                                    child: Row(
                                      children: [
                                        Icon(Icons.call,
                                            color:
                                                themeState.isDarkTheme == true
                                                    ? Color.fromRGBO(
                                                        212, 212, 212, 1)
                                                    : Color.fromARGB(
                                                        255, 54, 54, 54)),
                                        SizedBox(width: 10),
                                        Text(
                                          _appService.selectedJobData[
                                                      'phone'] ==
                                                  null
                                              ? " "
                                              : _appService.selectedJobData[
                                                      'is_locked']
                                                  ? _appService.selectedJobData[
                                                              'phone']
                                                          .toString()
                                                          .substring(0, 3) +
                                                      "*********"
                                                  : _appService
                                                      .selectedJobData['phone']
                                                      .toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                themeState.isDarkTheme == true
                                                    ? Color.fromRGBO(
                                                        212, 212, 212, 1)
                                                    : Color.fromARGB(
                                                        255, 54, 54, 54),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      if (!kIsWeb) {
                                        if (Platform.isAndroid ||
                                            Platform.isIOS) {
                                          if (_appService.selectedJobData[
                                                      'phone'] !=
                                                  null &&
                                              _appService.selectedJobData[
                                                      'phone'] !=
                                                  "")
                                            _callNumber(_appService
                                                .selectedJobData['phone']);
                                        }
                                      }
                                    },
                                  ),
                                  if (!_appService.isFromBrowser)
                                    SizedBox(
                                      height: 10,
                                    ),
                                  if (!_appService.isFromBrowser)
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/status.png',
                                          fit: BoxFit.cover,
                                          width: 22,
                                          color:
                                              Color.fromRGBO(79, 162, 219, 1),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          Languages.of(context)!.activeStatus,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: themeState.isDarkTheme ==
                                                      true
                                                  ? Color.fromRGBO(
                                                      212, 212, 212, 1)
                                                  : Color.fromARGB(
                                                      255, 54, 54, 54),
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  if (!_appService.isFromBrowser)
                                    SizedBox(height: 13),
                                  if (!_appService.isFromBrowser)
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/offers.png',
                                          fit: BoxFit.cover,
                                          width: 20,
                                          color:
                                              Color.fromRGBO(79, 162, 219, 1),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          Languages.of(context)!.offers +
                                              ' : ' +
                                              _appService.selectedJobData[
                                                      'total_proporsal']
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: themeState.isDarkTheme ==
                                                      true
                                                  ? Color.fromRGBO(
                                                      212, 212, 212, 1)
                                                  : Color.fromARGB(
                                                      255, 54, 54, 54),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          _appService.selectedJobData['questions'] == null
                              ? Container()
                              : _appService.selectedJobData['questions']
                                          .length ==
                                      0
                                  ? Container()
                                  : Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (var question in _appService
                                              .selectedJobData['questions'])
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    question['question_text'],
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            79, 162, 219, 1),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                      question['value']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: themeState
                                                                      .isDarkTheme ==
                                                                  true
                                                              ? Color.fromRGBO(
                                                                  212,
                                                                  212,
                                                                  212,
                                                                  1)
                                                              : Color.fromARGB(
                                                                  255,
                                                                  54,
                                                                  54,
                                                                  54))),
                                                  SizedBox(height: 5),
                                                  Divider(
                                                    thickness: 1,
                                                    color: themeState
                                                                .isDarkTheme ==
                                                            true
                                                        ? Color.fromRGBO(
                                                            51, 51, 51, 1)
                                                        : Color.fromRGBO(
                                                            190, 190, 190, 1),
                                                  ),
                                                  SizedBox(height: 5),
                                                ])
                                        ],
                                      )),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Languages.of(context)!.description,
                                    style: TextStyle(
                                        color: Color.fromRGBO(79, 162, 219, 1),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    _appService.selectedJobData['description'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: themeState.isDarkTheme == false
                                            ? Colors.black87
                                            : Color.fromRGBO(194, 194, 194, 1)),
                                  ),
                                ],
                              )),
                          if (_appService.selectedJobData['files'] != null &&
                              _appService.selectedJobData['files'].length != 0)
                            image_carousel,
                          if (_appService.user['is_worker'] == true &&
                              _appService.user['user_type'] == "work")
                            Divider(
                              thickness: 1,
                              color: themeState.isDarkTheme == true
                                  ? Color.fromRGBO(51, 51, 51, 1)
                                  : Color.fromRGBO(190, 190, 190, 1),
                            ),
                          if (_appService.user['is_worker'] == true &&
                              _appService.user['user_type'] == "work")
                            Container(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  Languages.of(context)!.aboutCustomer,
                                  style: TextStyle(
                                      color: Color.fromRGBO(79, 162, 219, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                          if (_appService.selectedJobData['customer'] != null)
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  displayTimeAgoFromTimestamp(
                                      _appService.selectedJobData['customer']
                                          ['date_joined']),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color.fromRGBO(194, 194, 194, 1)),
                                )),
                          Divider(
                            thickness: 1,
                            color: themeState.isDarkTheme == true
                                ? Color.fromRGBO(51, 51, 51, 1)
                                : Color.fromRGBO(190, 190, 190, 1),
                          ),
                          _appService.selectedJobData['reviews_info'] == null
                              ? Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    Languages.of(context)!.noOffers,
                                    style: TextStyle(
                                        color: Color.fromRGBO(79, 162, 219, 1),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ))
                              : _appService.selectedJobData['reviews_info']
                                          .length ==
                                      0
                                  ? Container(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        Languages.of(context)!.noOffers,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(79, 162, 219, 1),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ))
                                  : Container(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        _appService
                                                .selectedJobData['reviews_info']
                                                .length
                                                .toString() +
                                            Languages.of(context)!
                                                .receivedOffers,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(79, 162, 219, 1),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      )),
                          _appService.selectedJobData['reviews_info'] != null &&
                                  _appService.selectedJobData['reviews_info']
                                          .length !=
                                      0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _appService
                                      .selectedJobData['reviews_info'].length,
                                  itemBuilder: (ctx, index) => Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Row(children: [
                                        RatingBar.builder(
                                          initialRating: double.parse(
                                              _appService.selectedJobData[
                                                      'reviews_info'][index]
                                                      ['medie']
                                                  .toString()),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
                                          ignoreGestures: true,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 0.1),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(_appService
                                            .selectedJobData['reviews_info']
                                                [index]['medie']
                                            .toString()),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('[ ' +
                                            Languages.of(context)!.reviews +
                                            ': ' +
                                            _appService
                                                .selectedJobData['reviews_info']
                                                    [index]['count']
                                                .toString() +
                                            ' ]')
                                      ])),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                      Languages.of(context)!.beFirstSend,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(
                                              194, 194, 194, 1)))),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: _appService.isFromBrowser
                      ? Container(
                          padding: EdgeInsets.all(10),
                          child: DefaultButton(
                              text: _appService.selectedJobData['costs']
                                          ['send_offer_to_request_cost'] ==
                                      0
                                  ? Languages.of(context)!.sendOffer +
                                      ' (' +
                                      Languages.of(context)!.free +
                                      ')'
                                  : Languages.of(context)!.sendOffer +
                                      ' ( ' +
                                      _appService.selectedJobData['costs']
                                              ['send_offer_to_request_cost']
                                          .toString() +
                                      ' © )',
                              press: () {
                                if (_appService.user['credits'] <
                                    _appService.selectedJobData['costs']
                                        ['send_offer_to_request_cost']) {
                                  GoRouter.of(context)
                                      .pushNamed(APP_PAGE.buyCredits.toName);
                                } else
                                  GoRouter.of(context)
                                      .pushNamed(APP_PAGE.newOffer.toName);
                              }))
                      : Container(
                          padding: EdgeInsets.all(10),
                          child: _appService.user['is_worker'] == true
                              ? _appService.selectedJobData['have_offers'] ==
                                      false
                                  ? DefaultButton(
                                      text: _appService.selectedJobData['costs']
                                                  [
                                                  'send_offer_to_request_cost'] ==
                                              0
                                          ? Languages.of(context)!.sendOffer +
                                              ' (' +
                                              Languages.of(context)!.free +
                                              ')'
                                          : Languages.of(context)!.sendOffer +
                                              ' ( ' +
                                              _appService
                                                  .selectedJobData['costs']
                                                      ['send_offer_to_request_cost']
                                                  .toString() +
                                              ' © )',
                                      press: () {
                                        if (_appService.user['credits'] <
                                            _appService.selectedJobData['costs']
                                                [
                                                'send_offer_to_request_cost']) {
                                          if (Platform.isIOS) {
                                            GoRouter.of(context).pushNamed(
                                                APP_PAGE
                                                    .buyCreditsApple.toName);
                                          } else {
                                            GoRouter.of(context).pushNamed(
                                                APP_PAGE.buyCredits.toName);
                                          }
                                        } else
                                          GoRouter.of(context).pushNamed(
                                              APP_PAGE.newOffer.toName);
                                      })
                                  : DefaultButton(
                                      text: Languages.of(context)!.update_offer,
                                      press: () {
                                        GoRouter.of(context).pushNamed(
                                            APP_PAGE.updateOffer.toName);
                                      })
                              : DefaultButton(
                                  text: Languages.of(context)!.viewOffers,
                                  press: () {
                                    GoRouter.of(context)
                                        .pushNamed(APP_PAGE.myJobOffers.toName);
                                  })),
                );
        });
  }

  AppBar appBar(BuildContext context, ChangeThemeState themeState) {
    return AppBar(
      centerTitle: true,
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: _appService.isFromBrowser
              ? PopupMenuButton(
                  onSelected: (value) {
                    if (value == 1) {
                      GoRouter.of(context).pushNamed(APP_PAGE.newOffer.toName);
                    }
                  },
                  position: PopupMenuPosition.under,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  // initialValue: 2,
                  child: Icon(
                    Icons.more_vert,
                    size: 25,
                    color: themeState.isDarkTheme == false
                        ? Colors.black
                        : Colors.white,
                  ),
                  itemBuilder: (context) => [
                        if (_appService.selectedJobData['is_locked'])
                          PopupMenuItem(
                            value: 1,
                            child: Container(
                                child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: themeState.isDarkTheme == false
                                      ? Colors.black
                                      : Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 9),
                                Text(
                                  Languages.of(context)!.sendOffer,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Expanded(child: Container()),
                                _appService.selectedJobData['costs']
                                            ['send_offer_to_request_cost'] ==
                                        0
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                                color: themeState.isDarkTheme ==
                                                        false
                                                    ? Color.fromRGBO(
                                                        44, 62, 80, 1)
                                                    : Colors.white70)),
                                        child: Text(Languages.of(context)!.free,
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: themeState.isDarkTheme ==
                                                        false
                                                    ? Color.fromRGBO(
                                                        44, 62, 80, 1)
                                                    : Colors.white70)),
                                      )
                                    : Text(
                                        _appService.selectedJobData['costs'][
                                                    'send_offer_to_request_cost']
                                                .toString() +
                                            " ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                SizedBox(width: 2),
                                Image.asset(
                                  'assets/images/credit.png',
                                  fit: BoxFit.cover,
                                  width: 17,
                                  color: themeState.isDarkTheme == false
                                      ? Colors.black
                                      : Colors.white70,
                                ),
                              ],
                            )),
                          )
                      ])
              : PopupMenuButton(
                  onSelected: (value) {
                    _onMenuItemSelected(value as int, context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  // initialValue: 2,
                  position: PopupMenuPosition.under,
                  child: Icon(
                    Icons.more_vert,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 2,
                          child: Text(Languages.of(context)!.cancel_request),
                        )
                      ]),
        )
      ],
      leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: () {}),
      title: Column(
        children: [
          Text(
            Languages.of(context)!.jobID +
                ' #' +
                _appService.selectedJobData['id'].toString(),
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
