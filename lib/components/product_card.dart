import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';
import '../../../constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:favorite_button/favorite_button.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({required this.productItem});
  final productItem;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  bool isLoading = false;
  var myFavoriteData;
  late AppService _appService;
  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    getHomePageDataList();
    super.initState();
  }

  Future<void> getHomePageDataList() async {
    dynamic myFavoriteData = _appService.homePageData['favorite'];
    if ((myFavoriteData.singleWhere(
            (it) => it['id'] == widget.productItem['id'],
            orElse: () => null)) !=
        null)
      setState(() {
        isFavorite = true;
      });
    setState(() {
      isLoading = true;
    });
  }

  Future<void> addFavoriteProduct() async {}

  Future<void> deleteFavoriteProduct() async {}

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.transparent,
            ),
          )
        : Container(
            margin: EdgeInsets.only(bottom: 7),
            decoration: BoxDecoration(
                color: !context.watch<AppService>().themeState.isDarkTheme!
                    ? Colors.white
                    : darkThemeCardBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            width: double.infinity,
            height: 143,
            child: Stack(children: [
              Row(
                children: [
                  Container(
                    width: getProportionateScreenWidth(160),
                    child: buildImage(),
                  ),
                  SizedBox(width: getProportionateScreenWidth(13)),
                  Expanded(
                      child: Container(
                          padding:
                              EdgeInsets.only(top: 17, bottom: 10, right: 10),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                    ),
                                    TextSpan(
                                        text: ' ' +
                                            widget.productItem['reviews']
                                                    ['starts']
                                                .toString() +
                                            ' ',
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                      text: '(' +
                                          widget.productItem['reviews']
                                                  ['total_reviews']
                                              .toString() +
                                          ')',
                                      style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 40,
                                child: Text(
                                  widget.productItem['title'] == null
                                      ? "notitle"
                                      : widget.productItem['title'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  "${widget.productItem['price']} ${widget.productItem['price_type']} ",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ))),
                ],
              ),
              Positioned(
                top: 17,
                right: 10,
                child: FavoriteButton(
                  isFavorite: isFavorite,
                  iconSize: 30,
                  iconColor: Colors.amber,
                  iconDisabledColor: Colors.grey,
                  valueChanged: (_isFavorite) async {
                    setState(() => {isFavorite = _isFavorite});
                    if (_isFavorite) {
                      addFavoriteProduct();
                      await _appService.addFavoriteToHome(widget.productItem);
                    } else {
                      deleteFavoriteProduct();
                      await _appService
                          .removeFavoriteToHome(widget.productItem);
                      // }
                    }
                  },
                ),
              )
            ]));
  }

  buildImage() {
    // return Image.asset('assets/images/placeholder1.png');
    if (widget.productItem['images']?.length == 0 ||
        widget.productItem['images'] == null) {
      return Image.asset(
        'assets/images/placeholder1.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    if (widget.productItem['images'][0]['img'].indexOf(';') > 0)
      widget.productItem['images'][0]['img'] = widget.productItem['images'][0]
              ['img']
          .substring(0, widget.productItem['images'][0]['img'].indexOf(';'));

    if (widget.productItem['images'][0]['img'] == null ||
        widget.productItem['images'][0]['img'].toString().isEmpty)
      return Image.asset(
        'assets/images/placeholder1.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    else
      return ExtendedImage.network(widget.productItem['images'][0]["img"],
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          compressionRatio: 0.2,
          cache: true,
          clearMemoryCacheIfFailed: true,
          clearMemoryCacheWhenDispose: true);
  }
}
