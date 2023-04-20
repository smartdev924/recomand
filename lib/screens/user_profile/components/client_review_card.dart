// import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';

class ClientReviewCard extends StatefulWidget {
  const ClientReviewCard({required this.reviewItem});
  final reviewItem;

  @override
  _ClientReviewCardState createState() => _ClientReviewCardState();
}

class _ClientReviewCardState extends State<ClientReviewCard> {
  String displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'week';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'month';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'year';
    }

    timeAgo = timeValue.toString() + ' ' + timeUnit;
    timeAgo += timeValue > 1 ? 's' : '';

    return timeAgo + ' ago';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: !context.watch<AppService>().themeState.isDarkTheme!
                ? Colors.white
                : Color.fromRGBO(27, 28, 30, 1),
            // border: Border(
            //   bottom: BorderSide(color: Color.fromRGBO(233, 233, 233, 1)),
            // ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        padding: EdgeInsets.fromLTRB(20, 18, 20, 16),
        width: double.infinity,
        // height: 179,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: (widget.reviewItem['reviewer']['avatar'] == null ||
                              widget.reviewItem['reviewer']['avatar'] == "")
                          ? Image.asset("assets/images/user.png")
                          : ExtendedImage.network(
                              widget.reviewItem['reviewer']['avatar'],
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
                            )),
                ),
                SizedBox(width: 17),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(
                                  widget.reviewItem['reviewer']['full_name'] ==
                                          null
                                      ? ""
                                      : widget.reviewItem['reviewer']
                                          ['full_name'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                )),
                                Text(
                                  displayTimeAgoFromTimestamp(
                                      widget.reviewItem['created_at']),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Color.fromRGBO(139, 139, 151, 1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )),
                        SizedBox(height: getProportionateScreenHeight(7)),
                        RatingBar.builder(
                          initialRating: widget.reviewItem['rating'] / 1.0,
                          // widget.reviewItem['rating'].toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (rating) {},
                        ),
                      ]),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(widget.reviewItem['review'],
                style: TextStyle(
                    color: Color.fromRGBO(139, 139, 151, 1),
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: 8,
            ),
          ],
        ));
  }
}
