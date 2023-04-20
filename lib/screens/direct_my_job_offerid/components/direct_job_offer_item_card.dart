import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/dotted_seperator.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DirectJobOfferItemCard extends StatefulWidget {
  const DirectJobOfferItemCard({required this.data});
  final data;

  @override
  _JobOfferItemCard2State createState() => _JobOfferItemCard2State();
}

class _JobOfferItemCard2State extends State<DirectJobOfferItemCard> {
  late AppService _appService;
  bool _customTileExpanded = false;
  bool creatingChattingRoom = false;
  bool isAwarded = false;
  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    initData();
    super.initState();
  }

  initData() async {
    if (_appService.selectedJobData['award'] != null) {
      if (_appService.selectedJobData['award']['awarded_user_id'] ==
          widget.data['user_id'])
        setState(() {
          isAwarded = true;
        });
    }
  }

  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color.fromRGBO(137, 138, 143, 0.5),
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: context.watch<AppService>().themeState.isDarkTheme == false
              ? Color.fromRGBO(249, 249, 255, 1)
              : Colors.black87,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color:
                    context.watch<AppService>().themeState.isDarkTheme == false
                        ? Color.fromRGBO(137, 138, 143, 0.5)
                        : Colors.transparent,
                blurRadius: 4.0,
                offset: Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    dynamic response = await _appService.getUserProfile(
                        userID: widget.data['user']['id']);
                    if (response is String || response == null) {
                      showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: response,
                          ));
                    } else {
                      _appService.selectedUserProfileData =
                          response.data['data'];
                      _appService.selecteduserProfilePhoneNumber =
                          widget.data['user']['phone'] == null
                              ? ""
                              : widget.data['user']['phone'];
                      GoRouter.of(context)
                          .pushNamed(APP_PAGE.userProfile.toName);
                    }
                  },
                  child: AdvancedAvatar(
                    size: 66,
                    image: (widget.data['user'] != null &&
                            widget.data['user']['avatar'] != null)
                        ? ExtendedImage.network(
                            widget.data['user']['avatar'],
                            clearMemoryCacheIfFailed: true,
                            clearMemoryCacheWhenDispose: true,
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.failed:
                                  return Image.asset(
                                    'assets/images/profile_sm.png',
                                  );

                                case LoadState.loading:
                                  return Image.asset(
                                    'assets/images/profile_sm.png',
                                  );
                                case LoadState.completed:
                                  break;
                              }
                              return null;
                            },
                          ).image
                        : AssetImage('assets/images/user.png'),
                    name: widget.data['user_id'].toString(),
                    statusColor: widget.data['user']['is_online']
                        ? Color.fromRGBO(76, 217, 100, 1)
                        : Color.fromRGBO(139, 139, 151, 1),
                    statusAngle: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5,
                      ),
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'User ID: ' + widget.data['user_id'].toString(),
                      widget.data['title'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Colors.black
                              : Colors.white),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      _appService.selectedJobData['city'] != null
                          ? _appService.selectedJobData['service']['name'] +
                              ', ' +
                              _appService.selectedJobData['city']['name']
                          : _appService.selectedJobData['service']['name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(137, 138, 143, 1)),
                    ),
                    if (widget.data['user'] != null &&
                        widget.data['user']['phone'] != null)
                      SizedBox(
                        height: 7,
                      ),
                    if (widget.data['user'] != null &&
                        widget.data['user']['phone'] != null)
                      Row(
                        children: [
                          Icon(Icons.phone_android,
                              size: 20,
                              color: Color.fromRGBO(137, 138, 143, 1)),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.data['user']['phone'],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(137, 138, 143, 1)),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 12,
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
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(79, 162, 219, 1)),
                    ),
                  ],
                )),
                Container(
                    width: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Color.fromRGBO(68, 68, 68, 1),
                        size: 20,
                      ),
                      onPressed: () {},
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                MySeparator(
                  color: context.watch<AppService>().themeState.isDarkTheme ==
                          false
                      ? Color.fromRGBO(224, 224, 224, 1)
                      : Color.fromARGB(255, 63, 63, 63),
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
                                : Colors.grey,
                          ),
                          color: context
                                      .watch<AppService>()
                                      .themeState
                                      .isDarkTheme ==
                                  false
                              ? Colors.white
                              : Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    color: Color.fromRGBO(111, 118, 126, 1)),
              ),
            if (_customTileExpanded)
              SizedBox(
                height: 15,
              ),
            if (_customTileExpanded)
              MySeparator(
                color:
                    context.watch<AppService>().themeState.isDarkTheme == false
                        ? Color.fromRGBO(224, 224, 224, 1)
                        : Color.fromARGB(255, 63, 63, 63),
              ),
            SizedBox(
              height: 15,
            ),
            if (widget.data['available_from'] != null &&
                widget.data['available_from'].toString().toLowerCase() !=
                    "null")
              Row(
                children: [
                  context.watch<AppService>().themeState.isDarkTheme == false
                      ? Image.asset(
                          'assets/images/start.png',
                          fit: BoxFit.cover,
                          width: 20,
                        )
                      : Image.asset(
                          'assets/images/start_dark.png',
                          fit: BoxFit.cover,
                          width: 20,
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
                        color: context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                false
                            ? Color.fromRGBO(68, 68, 68, 1)
                            : Colors.white),
                  )
                ],
              ),
            if (widget.data['available_from'] != null &&
                widget.data['available_from'].toString().toLowerCase() !=
                    "null")
              SizedBox(
                height: 15,
              ),
            if (widget.data['deadline'] != null &&
                widget.data['dead_line'].toString().toLowerCase() != "null")
              Row(
                children: [
                  context.watch<AppService>().themeState.isDarkTheme == false
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
                    'DEAD LINE:  ' +
                        widget.data['dead_line'].toString() +
                        ' ' +
                        (widget.data['offer_type'] == null ||
                                widget.data['offer_type']
                                        .toString()
                                        .toLowerCase() ==
                                    "null"
                            ? ""
                            : widget.data['offer_type'].toUpperCase()),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                false
                            ? Color.fromRGBO(68, 68, 68, 1)
                            : Colors.white),
                  )
                ],
              ),
            if (widget.data['deadline'] != null &&
                widget.data['dead_line'].toString().toLowerCase() != "null")
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
                      )
                    : Image.asset(
                        'assets/images/offer_sm.png',
                        fit: BoxFit.cover,
                        width: 17,
                        color: Colors.white70,
                      ),
                SizedBox(
                  width: 13,
                ),
                Text(
                  Languages.of(context)!.offer +
                      ' : ' +
                      widget.data['price'].toString() +
                      ' ' +
                      (widget.data['currency_type'] == null
                          ? ""
                          : widget.data['currency_type']),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          context.watch<AppService>().themeState.isDarkTheme ==
                                  false
                              ? Color.fromRGBO(68, 68, 68, 1)
                              : Colors.white),
                )
              ],
            ),
            SizedBox(height: 25),
            MySeparator(
              color: context.watch<AppService>().themeState.isDarkTheme == false
                  ? Color.fromRGBO(224, 224, 224, 1)
                  : Color.fromARGB(255, 63, 63, 63),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    if (widget.data['user']['phone'] != null) if (!kIsWeb &&
                        (Platform.isAndroid || Platform.isIOS))
                      _callNumber(widget.data['user']['phone']);
                    else
                      showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: Languages.of(context)!.noPhoneNumber,
                          ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(79, 162, 219, 1),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Colors.white
                                  : Colors.black,
                              blurRadius: 4.0,
                              offset: Offset(0, 4))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                false
                            ? 0
                            : 5))),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(Icons.call,
                                color: Color.fromRGBO(40, 40, 41, 1), size: 20),
                          ),
                          TextSpan(
                              text: "  " +
                                  Languages.of(context)!.call.toUpperCase(),
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Color.fromRGBO(40, 40, 41, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (widget.data['chat_room'] == null) {
                      setState(() {
                        creatingChattingRoom = true;
                      });
                      dynamic response = await _appService.createChatRoom(
                          offerID: widget.data['id']);
                      setState(() {
                        creatingChattingRoom = false;
                      });
                      if (response is String || response == null) {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: response,
                          ),
                        );
                      } else {
                        _appService.selectedChatRoomData =
                            response.data['room'];
                        _appService.selectedChatUser = widget.data['user'];
                        if (kIsWeb) {
                          GoRouter.of(context)
                              .pushNamed(APP_PAGE.chatView.toName);
                        } else if (Platform.isAndroid || Platform.isIOS) {
                          GoRouter.of(context)
                              .pushNamed(APP_PAGE.chatView.toName);
                        } else {
                          GoRouter.of(context)
                              .pushNamed(APP_PAGE.chatViewDekstop.toName);
                        }
                      }
                    } else {
                      _appService.selectedChatRoomData =
                          widget.data['chat_room'];
                      _appService.selectedChatUser = widget.data['user'];
                      if (kIsWeb) {
                        GoRouter.of(context)
                            .pushNamed(APP_PAGE.chatView.toName);
                      } else if (Platform.isAndroid || Platform.isIOS) {
                        GoRouter.of(context)
                            .pushNamed(APP_PAGE.chatView.toName);
                      } else {
                        GoRouter.of(context)
                            .pushNamed(APP_PAGE.chatViewDekstop.toName);
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(79, 162, 219, 1),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Colors.white
                                  : Colors.black,
                              blurRadius: 4.0,
                              offset: Offset(0, 4))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                false
                            ? 0
                            : 5))),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(Icons.message,
                                color: Color.fromRGBO(40, 40, 41, 1), size: 20),
                          ),
                          creatingChattingRoom
                              ? WidgetSpan(
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Color.fromARGB(255, 37, 37, 37),
                                      )))
                              : TextSpan(
                                  text: "  " +
                                      Languages.of(context)!.chat.toUpperCase(),
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Color.fromRGBO(40, 40, 41, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (_appService.selectedJobData['award'] == null) {
                      dynamic response = await _appService.awardUserToRequestID(
                          userID: widget.data['user']['id'],
                          requestID: widget.data['request_id']);
                      if (response is String || response == null) {
                        showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: response,
                            ));
                      } else {
                        setState(() {
                          isAwarded = true;
                        });
                        _appService.selectedJobData['award'] = response.data[0];
                      }
                    } else if (isAwarded) {
                      dynamic resp = await _appService.getUserProfile(
                          userID: widget.data['user']['id']);
                      if (resp is String || resp == null) {
                        showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: resp,
                            ));
                      } else {
                        _appService.selectedUserReviewed = resp.data['data'];
                        _appService.selectedRequestIDReviewed =
                            widget.data['request_id'];
                        GoRouter.of(context)
                            .pushNamed(APP_PAGE.writeReview.toName);
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(79, 162, 219, 1),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Colors.white
                                  : Colors.black,
                              blurRadius: 4.0,
                              offset: Offset(0, 4))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(context
                                    .watch<AppService>()
                                    .themeState
                                    .isDarkTheme ==
                                false
                            ? 0
                            : 5))),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: isAwarded
                                  ? Icon(Icons.star,
                                      color: Color.fromRGBO(40, 40, 41, 1),
                                      size: 20)
                                  : Image.asset(
                                      "assets/images/buy_credits.png",
                                      width: 20,
                                    )),
                          TextSpan(
                              text: "  " +
                                  (isAwarded
                                      ? Languages.of(context)!.feedBacks
                                      : Languages.of(context)!
                                          .award
                                          .toUpperCase()),
                              style: TextStyle(
                                  color: Color.fromRGBO(40, 40, 41, 1),
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
