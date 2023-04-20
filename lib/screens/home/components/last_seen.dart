import 'package:flutter/material.dart';
import 'package:localservice/components/product_card.dart';
import './section_title.dart';
import '../../../size_config.dart';

// ignore: must_be_immutable
class LastSeenProducts extends StatelessWidget {
  dynamic lastSeenProducts;

  LastSeenProducts({required this.lastSeenProducts});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 17, right: 17),
        padding: EdgeInsets.all(10),
        child: Column(children: [
          SectionTitle(
            title: 'Languages.of(context)!.lastseenservice',
          ),
          SizedBox(height: getProportionateScreenHeight(7)),
          lastSeenProducts?.length == 0 || lastSeenProducts == null
              ? Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.new_releases_outlined,
                    size: 30,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Languages.of(context)!.noproduct',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ])
              : Container(
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
                        for (int i = 0; i < lastSeenProducts.length; i++)
                          ProductCard(productItem: lastSeenProducts[i]),
                      ],
                    ),
                  ),
                )
        ]));
  }
}
