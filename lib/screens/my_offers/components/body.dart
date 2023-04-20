import 'package:flutter/material.dart';
import 'package:localservice/components/dotted_seperator.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'my_offer_item_card.dart';
import 'package:skeletons/skeletons.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  bool isLoaded = false;
  bool offerTab = true;

  dynamic myJobOfferList = [];
  dynamic myUnlockedRequests = [];
  ScrollController offersScrollController = ScrollController();
  ScrollController requestScrollController = ScrollController();
  bool isLoadMoreoffers = false;
  bool isLoadMoreRequests = false;
  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    loadData();

    offersScrollController.addListener(() {
      if (offersScrollController.position.pixels ==
          offersScrollController.position.maxScrollExtent) {
        if (!isLoadMoreoffers) loadMoreOffers();
      }
    });
    requestScrollController.addListener(() {
      if (requestScrollController.position.pixels ==
          requestScrollController.position.maxScrollExtent) {
        if (!isLoadMoreRequests) loadMoreUnlockedRequests();
      }
    });
  }

  @override
  void dispose() {
    offersScrollController.dispose();
    requestScrollController.dispose();
    super.dispose();
  }

  Future<void> loadMoreOffers() async {
    setState(() {
      isLoadMoreoffers = true;
    });
    dynamic response =
        await _appService.getMyOffers(offset: myJobOfferList.length);

    if (!mounted) return;

    if (response is String || response == null) {
      setState(() {
        isLoadMoreoffers = false;
      });
      return;
    }
    setState(() {
      isLoadMoreoffers = false;
      dynamic datalist = response.data['data']
          .where((data) => data['request_id'] != null)
          .toList();
      myJobOfferList.addAll(datalist);
    });
  }

  Future<void> loadMoreUnlockedRequests() async {
    setState(() {
      isLoadMoreRequests = true;
    });
    dynamic response = await _appService.getMyUnlockedRequests(
        offset: myUnlockedRequests.length);

    if (!mounted) return;

    if (response is String || response == null) {
      setState(() {
        isLoadMoreRequests = false;
      });
      return;
    }
    setState(() {
      isLoadMoreRequests = false;
      myUnlockedRequests.addAll(response.data['data']);
    });
  }

  Future<void> loadData() async {
    dynamic response = await _appService.getMyOffers();
    dynamic response1 = await _appService.getMyUnlockedRequests();
    if (!mounted) return;
    setState(() {
      isLoaded = true;
    });
    if (response1 is String || response1 == null) {
      myUnlockedRequests = null;
    } else {
      myUnlockedRequests = response1.data['data'];
    }

    if (response is String || response == null) {
      myJobOfferList = null;
    } else {
      myJobOfferList = response.data['data']
          .where((data) => data['request_id'] != null)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context
            .watch<AppService>()
            .themeState
            .customColors[AppColors.primaryBackgroundColor],
        body: Column(
          children: [
            SizedBox(
              height: 7.5,
            ),
            isLoaded
                ? myJobOfferList == null
                    ? Center(
                        child: Text(Languages.of(context)!.noItems),
                      )
                    : myJobOfferList.length != 0
                        ? Flexible(
                            child: RefreshIndicator(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    controller: offersScrollController,
                                    itemCount: myJobOfferList.length,
                                    itemBuilder: (ctx, index) =>
                                        MyOfferItemCard(
                                            data: myJobOfferList[index])),
                                onRefresh: () {
                                  return loadData();
                                }))
                        : Flexible(
                            fit: FlexFit.tight,
                            child: Center(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Languages.of(context)!.noOffers,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 300,
                                  child: Text(
                                    Languages.of(context)!.noOffersDesc,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(176, 176, 176, 1)),
                                  ),
                                )
                              ],
                            )))
                : Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (ctx, index) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            margin: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color.fromRGBO(137, 138, 143, 0.5),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme ==
                                      false
                                  ? Colors.white
                                  : Color.fromRGBO(13, 13, 13, 1),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color.fromRGBO(137, 138, 143, 0.5),
                                    blurRadius: 2.0,
                                    offset: Offset(0, 2))
                              ],
                            ),
                            child: Column(
                              children: [
                                SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 3,
                                      spacing: 4,
                                      lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 19,
                                        minLength: 122,
                                      )),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                MySeparator(
                                  color: context
                                              .watch<AppService>()
                                              .themeState
                                              .isDarkTheme ==
                                          false
                                      ? Color.fromRGBO(224, 224, 224, 1)
                                      : Color.fromRGBO(137, 138, 143, 1),
                                ),
                                SizedBox(
                                  height: 23,
                                ),
                                SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 3,
                                      spacing: 15,
                                      lineStyle: SkeletonLineStyle(
                                          randomLength: true,
                                          height: 17,
                                          minLength: 122,
                                          maxLength: 180)),
                                )
                              ],
                            )))),
            if (isLoadMoreoffers)
              Container(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator())
          ],
        )
        // ],
        );
  }
}
