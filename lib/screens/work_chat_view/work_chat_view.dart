import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/services/AppService.dart';
import './components/body.dart';
import '../../size_config.dart';

class WorkChatViewScreen extends StatefulWidget {
  static const routeName = '/work-chat-view';

  @override
  State<WorkChatViewScreen> createState() => _WorkChatViewScreenState();
}

class _WorkChatViewScreenState extends State<WorkChatViewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Body(),
    );
  }

  PreferredSize appBar(BuildContext context) {
    late AppService _appService =
        Provider.of<AppService>(context, listen: false);
    return PreferredSize(
      child: Container(
        child: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
              ),
              onPressed: (() => GoRouter.of(context)
                  .pushNamed(APP_PAGE.conversation.toName))),
          elevation: 0.0,
          actions: [],
          title: Column(
            children: [
              Text(
                _appService.selectedChatUser['full_name'] == null
                    ? ""
                    : _appService.selectedChatUser['full_name'],
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }
}
