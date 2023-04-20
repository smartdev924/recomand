import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:localservice/components/default_button.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/services/AppService.dart';
import 'package:provider/provider.dart';
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
  double reviewRating = 5;
  String review = "";
  late AppService appService;
  bool hideReview = false;
  bool sendingReview = false;

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

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                Languages.of(context)!.howWasService,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(218, 218, 218, 1)),
              ),
              SizedBox(
                height: 30,
              ),
              AdvancedAvatar(
                size: 110,
                image: (appService.selectedUserReviewed['avatar'] != null &&
                        appService.selectedUserReviewed['avatar'] != "")
                    ? ExtendedImage.network(
                        appService.selectedUserReviewed['avatar'],
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
                name: appService.selectedUserReviewed['full_name'] == null
                    ? ""
                    : appService.selectedUserReviewed['full_name'],
                statusColor:
                    appService.selectedUserReviewed['is_online'] == true
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
              SizedBox(
                height: 10,
              ),
              Text(
                  appService.selectedUserReviewed['full_name'] == null
                      ? ""
                      : appService.selectedUserReviewed['full_name'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              SizedBox(
                height: 30,
              ),
              RatingBar.builder(
                initialRating: reviewRating,
                minRating: 0,
                direction: Axis.horizontal,
                tapOnlyMode: true,
                itemCount: 5,
                itemSize: 50,
                itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Color.fromRGBO(241, 185, 41, 1)),
                onRatingUpdate: (rating) {
                  setState(() {
                    reviewRating = rating;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  setState(() {
                    review = value;
                  });
                },
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: true,
                  fillColor:
                      context.watch<AppService>().themeState.isDarkTheme ==
                              false
                          ? Color.fromRGBO(242, 243, 245, 1)
                          : Color.fromARGB(255, 65, 65, 65),
                  contentPadding: EdgeInsets.only(
                    top: 10,
                    right: 15,
                    left: 15,
                    bottom: 25,
                  ),
                  isDense: true,
                  hintText: Languages.of(context)!.writeReview,
                ),
              ),
              CheckboxListTile(
                title: Text(Languages.of(context)!.keepMeReviewHidden),
                controlAffinity: ListTileControlAffinity.leading,
                value: hideReview,
                onChanged: (bool? value) {
                  setState(() {
                    hideReview = value!;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              sendingReview
                  ? CircularProgressIndicator()
                  : DefaultButton(
                      text: Languages.of(context)!.lab_send,
                      press: () async {
                        if (review == "") {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: Languages.of(context)!.inputReviewError,
                            ),
                          );
                        } else {
                          setState(() {
                            sendingReview = true;
                          });
                          dynamic response = await appService.writeUserReview(
                              review: review,
                              requestID: appService.selectedRequestIDReviewed,
                              userID: appService.selectedUserReviewed['id'],
                              is_hidden: hideReview,
                              rating: reviewRating.round());
                          setState(() {
                            sendingReview = false;
                          });
                          if (response is String || response == null) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                message: response,
                              ),
                            );
                          } else {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.success(
                                message: Languages.of(context)!.reviewedSuccess,
                              ),
                            );
                          }
                        }
                      },
                    ),
            ],
          ),
        ));
  }
}
