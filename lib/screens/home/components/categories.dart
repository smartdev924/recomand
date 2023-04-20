import 'package:flutter/material.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/size_config.dart';

// ignore: must_be_immutable
class Categories extends StatefulWidget {
  dynamic categoryList;

  Categories({required this.categoryList});
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: 17, right: 0),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          height: 120,
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8),
          //     color: !context.watch<AppService>().themeState.isDarkTheme!
          //         ? Colors.white
          //         : darkThemeCardBackgroundColor),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.categoryList.length,
              itemBuilder: (ctx, index) => CategoryCard(
                    icon: widget.categoryList[index]['image'],
                    text: widget.categoryList[index]['title']
                            .toString()
                            .substring(0, 7) +
                        '...',
                    press: () => {},
                  )),
        )),
        Container(
            margin: EdgeInsets.only(left: 0, right: 17),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            height: 120,
            child: CategoryCard(
              icon: '',
              text: Languages.of(context)!.seeAll,
              press: () {},
            ))
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(left: 7.5, right: 7.5),
          child: SizedBox(
            width: getProportionateScreenWidth(58),
            child: Column(
              children: [
                Container(
                    width: 72,
                    height: 61,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(100, 174, 223, 1),
                    ),
                    child: icon != ''
                        ? ClipRRect(
                            child: Image.network(
                              icon,
                              height: 55,
                              width: 65,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Icon(
                            Icons.arrow_forward,
                            size: 25,
                            color: Colors.black,
                          )),
                SizedBox(
                  height: 4,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, letterSpacing: -0.3),
                ),
              ],
            ),
          ),
        ));
  }
}
