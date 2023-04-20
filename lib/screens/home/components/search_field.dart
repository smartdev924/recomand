import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  final TextEditingController eCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _appService = Provider.of<AppService>(context, listen: false);
    return Container(
      width: SizeConfig.screenWidth! - getProportionateScreenWidth(46),
      // height: 50,
      decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: eCtrl,
        maxLines: null,
        autovalidateMode: AutovalidateMode.always,
        textInputAction: TextInputAction.none,
        // ignore: missing_return
        validator: (value) {
          if (value?.isEmpty == false) {
            if (value != null && value.contains('\n')) {
              eCtrl.clear(); // Clear the Text area
              WidgetsBinding.instance.addPostFrameCallback((_) {
                var singleline = value.trim();
                _appService.setKeywords(singleline);
                GoRouter.of(context).pushNamed(APP_PAGE.searchProducts.toName);
              });
            }
          }
          return null;
        },
        // onChanged: (value) {
        //   // search value 🔍
        // },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(19),
          ),
          hintText: ' Languages.of(context)!.searchproduct',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
