import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/components/custom_bottom_navigation_bar.dart';
import 'package:localservice/size_config.dart';
import './components/body.dart';

class FaqScreen extends StatefulWidget {
  static var routeName = "/faq";
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBar(context),
      body: Body(isSearch: isSearch),
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedMenu: Menu.profile),
    );
  }

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      child: Container(
        child: AppBar(
          title: Text(
            'FAQ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
              ),
              onPressed: (() => GoRouter.of(context).pop())),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = !isSearch;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ],
            )
          ],
          elevation: 0.0,
        ),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }
}
