// import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:localservice/components/product_card.dart';

import './section_title.dart';
import '../../../size_config.dart';

import 'package:localservice/localization/language/languages.dart';

// ignore: must_be_immutable
class MyFavoriteProducts extends StatelessWidget {
  dynamic myFavoriteProducts;

  MyFavoriteProducts({required this.myFavoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 17, right: 17),
        padding: EdgeInsets.all(10),
        child: Column(children: [
          SectionTitle(
            title: Languages.of(context)!.favorites,
          ),
          SizedBox(height: getProportionateScreenHeight(7)),
          myFavoriteProducts?.length == 0 || myFavoriteProducts == null
              ? Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.heart_broken,
                    size: 30,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Languages.of(context)!.nofavorite',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ])
              : Container(
                  // height: 315,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(100, 174, 223, 0.5)),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < myFavoriteProducts.length; i++)
                          ProductCard(productItem: myFavoriteProducts[i]),
                      ],
                    ),
                  ),
                )
        ]));
  }
}
