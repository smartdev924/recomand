import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/dotted_seperator.dart';
import 'package:localservice/cubit/theme_module/provider/theme_cubit.dart';
import 'package:localservice/cubit/theme_module/states/change_theme_states.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/screens/user_profile/components/client_review_card.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Body extends StatefulWidget {
  const Body(
      // key? key,
      );
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService appService;

  @override
  void initState() {
    appService = Provider.of<AppService>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    //...
    super.dispose();
    //...
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: (() => GoRouter.of(context).pop())),
      title: Column(
        children: [
          Text(
            appService.selectedUserProfileData == null
                ? ""
                : appService.selectedUserProfileData['full_name'] == null
                    ? ""
                    : appService.selectedUserProfileData['full_name'],
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
        bloc: changeThemeCubit,
        builder: (context, themeState) {
          Locale myLocale = Localizations.localeOf(context);
          return Scaffold(
            backgroundColor: themeState.isDarkTheme == false
                ? Colors.white
                : Color.fromRGBO(23, 23, 23, 1),
            body: appService.selectedUserProfileData == null
                ? Container()
                : SingleChildScrollView(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  child: AdvancedAvatar(
                                    size: 66,
                                    image: (appService.selectedUserProfileData[
                                                    'avatar'] !=
                                                null &&
                                            appService.selectedUserProfileData[
                                                    'avatar'] !=
                                                "")
                                        ? ExtendedImage.network(
                                            appService.selectedUserProfileData[
                                                'avatar'],
                                            clearMemoryCacheIfFailed: true,
                                            clearMemoryCacheWhenDispose: true,
                                            loadStateChanged:
                                                (ExtendedImageState state) {
                                              switch (state
                                                  .extendedImageLoadState) {
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
                                    name: appService.selectedUserProfileData[
                                                'full_name'] ==
                                            null
                                        ? ""
                                        : appService.selectedUserProfileData[
                                            'full_name'],
                                    statusColor:
                                        appService.selectedUserProfileData[
                                                'is_online']
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
                                      appService.selectedUserProfileData[
                                                  'full_name'] ==
                                              null
                                          ? ""
                                          : appService.selectedUserProfileData[
                                              'full_name'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: themeState.isDarkTheme == false
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      appService.selectedUserProfileData[
                                                  'profesion'] ==
                                              ""
                                          ? ""
                                          : appService.selectedUserProfileData[
                                              'profesion'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(137, 138, 143, 1)),
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
                                                      : myLocale.countryCode
                                                          .toString())
                                              .format(DateTime.parse(
                                            appService.selectedUserProfileData[
                                                'created_at'],
                                          )) +
                                          ',  ' +
                                          DateFormat.jm(myLocale.countryCode
                                                          .toString()
                                                          .toLowerCase() ==
                                                      "us"
                                                  ? "en"
                                                  : myLocale.countryCode
                                                      .toString())
                                              .format(DateTime.parse(
                                            appService.selectedUserProfileData[
                                                'created_at'],
                                          )),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(79, 162, 219, 1)),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MySeparator(
                              color: themeState.isDarkTheme == false
                                  ? Color.fromRGBO(224, 224, 224, 1)
                                  : Color.fromARGB(255, 133, 133, 133),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (appService
                                            .selecteduserProfilePhoneNumber !=
                                        "") if (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
                                      _callNumber(appService
                                          .selecteduserProfilePhoneNumber);
                                    else {
                                      showTopSnackBar(
                                          Overlay.of(context),
                                          CustomSnackBar.error(
                                            message: Languages.of(context)!
                                                .noPhoneNumber,
                                          ));
                                    }
                                  },
                                  child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 13),
                                      child: Row(
                                        children: [
                                          Icon(Icons.call,
                                              color: Color.fromRGBO(
                                                  141, 141, 149, 1)),
                                          Text(
                                              "  " +
                                                  Languages.of(context)!
                                                      .contact,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    141, 141, 149, 1),
                                              ))
                                        ],
                                      )),
                                ),
                                InkWell(
                                  child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 13),
                                      child: Row(
                                        children: [
                                          Icon(Icons.share,
                                              color: Color.fromRGBO(
                                                  141, 141, 149, 0.5)),
                                          Text(
                                              "  " +
                                                  Languages.of(context)!.share,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    141, 141, 149, 0.5),
                                              ))
                                        ],
                                      )),
                                ),
                                InkWell(
                                    onTap: () async {
                                      dynamic response = await appService
                                          .addFavoriteWorkerByID(
                                              user_id: appService
                                                      .selectedUserProfileData[
                                                  'id']);
                                      if (response is String ||
                                          response == null) {
                                        showTopSnackBar(
                                            Overlay.of(context),
                                            CustomSnackBar.error(
                                              message: response,
                                            ));
                                      } else {
                                        showTopSnackBar(
                                            Overlay.of(context),
                                            CustomSnackBar.success(
                                              message:
                                                  "This user added to your favorites.",
                                            ));
                                      }
                                    },
                                    child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 13),
                                        child: Row(
                                          children: [
                                            Icon(Icons.favorite_outline,
                                                color: Color.fromRGBO(
                                                    141, 141, 149, 1)),
                                            Text(
                                                "  " +
                                                    Languages.of(context)!
                                                        .favorite,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      141, 141, 149, 1),
                                                ))
                                          ],
                                        )))
                              ],
                            ),
                            MySeparator(
                              color: themeState.isDarkTheme == false
                                  ? Color.fromRGBO(224, 224, 224, 1)
                                  : Color.fromARGB(255, 133, 133, 133),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                    Languages.of(context)!.about,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color.fromRGBO(137, 138, 143, 1)),
                                  )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    appService.selectedUserProfileData[
                                                'description'] ==
                                            null
                                        ? ""
                                        : appService.selectedUserProfileData[
                                            'description'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(137, 138, 143, 1)),
                                  )
                                ],
                              ),
                            ),
                            MySeparator(
                              color: themeState.isDarkTheme == false
                                  ? Color.fromRGBO(224, 224, 224, 1)
                                  : Color.fromARGB(255, 133, 133, 133),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              Languages.of(context)!.photos,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(137, 138, 143, 1)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            appService.selectedUserProfileData['portofolio']
                                        .length ==
                                    0
                                ? Container(child: Text(""))
                                : Container(
                                    height: 115,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: appService
                                            .selectedUserProfileData[
                                                'portofolio']
                                            .length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (ctx, int) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            width: 115,
                                            height: 115,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                          );
                                        })),
                            SizedBox(
                              height: 20,
                            ),
                            MySeparator(
                              color: themeState.isDarkTheme == false
                                  ? Color.fromRGBO(224, 224, 224, 1)
                                  : Color.fromARGB(255, 133, 133, 133),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              Languages.of(context)!.feedBacks,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(137, 138, 143, 1)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            appService.selectedUserProfileData['reviews'] ==
                                        null ||
                                    appService
                                            .selectedUserProfileData['reviews']
                                            .length ==
                                        0
                                ? Container(child: Text(""))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: appService
                                        .selectedUserProfileData['reviews']
                                        .length,
                                    itemBuilder: (ctx, index) {
                                      return ClientReviewCard(
                                          reviewItem: appService
                                                  .selectedUserProfileData[
                                              'reviews'][index]);
                                    })
                          ],
                        ))),
            appBar: appBar(context),
          );
        });
  }
}
