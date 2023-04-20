import 'package:flutter/material.dart';
import 'package:localservice/components/product_card.dart';
import './section_title.dart';
import '../../../size_config.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class ForYouProducts extends StatelessWidget {
  dynamic forYouProducts;

  ForYouProducts({required this.forYouProducts});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 17, right: 17),
        padding: EdgeInsets.only(right: 10, left: 10),
        child: Column(children: [
          SectionTitle(
            title: 'Languages.of(context)!.recommendedforyou',
          ),
          SizedBox(height: getProportionateScreenHeight(7)),
          Container(
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 1.0, color: Color.fromRGBO(100, 174, 223, 0.5)),
                ),
              ),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                itemCount: forYouProducts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductCard(productItem: forYouProducts[index]);
                },
              ))
        ]));
  }
}
