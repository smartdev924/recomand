import 'package:flutter/material.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/size_config.dart';
import 'package:localservice/theme/theme_colors.dart';
import '../../../constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extended_image/extended_image.dart';

class ServiceItem extends StatefulWidget {
  const ServiceItem({required this.serviceItem});
  final serviceItem;

  @override
  _ServiceItemState createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  bool isFavorite = false;
  bool isLoading = false;
  var myFavoriteData;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        margin: EdgeInsets.only(right: 11),
        decoration: BoxDecoration(
            color: !context.watch<AppService>().themeState.isDarkTheme!
                ? Colors.white
                : darkThemeCardBackgroundColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: context.watch<AppService>().themeState.isDarkTheme ==
                          false
                      ? Color.fromRGBO(137, 138, 143, 0.5)
                      : Color.fromRGBO(30, 30, 30, 0.98),
                  blurRadius: 4.0,
                  offset: Offset(1, 4))
            ],
            borderRadius: BorderRadius.all(Radius.circular(5))),
        width: getProportionateScreenWidth(144),
        height: getProportionateScreenWidth(193),
        child: buildImage(),
      ),
      Container(
        margin: EdgeInsets.only(top: 13),
        width: getProportionateScreenWidth(144),
        child: Text(
          widget.serviceItem['name'],
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: context
                  .watch<AppService>()
                  .themeState
                  .customColors[AppColors.primaryTextColor1]),
        ),
      )
    ]);
  }

  buildImage() {
    if (widget.serviceItem['image'] == null ||
        widget.serviceItem['image'].toString().isEmpty)
      return Image.asset(
        'assets/images/placeholder1.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    else
      return ExtendedImage.network(widget.serviceItem['image'],
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          compressionRatio: 0.2,
          cache: true,
          clearMemoryCacheIfFailed: true,
          clearMemoryCacheWhenDispose: true);
  }
}
