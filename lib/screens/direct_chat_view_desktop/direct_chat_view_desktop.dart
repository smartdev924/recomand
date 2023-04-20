import 'package:flutter/material.dart';
import 'package:localservice/size_config.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import './components/body.dart';

class DirectChatViewDesktopScreen extends StatelessWidget {
  static const routeName = '/direct-chat-view-desktop/:roomID';
  final String? roomID;
  DirectChatViewDesktopScreen({
    this.roomID,
  });
  @override
  Widget build(BuildContext context) {
    late AppService _appService =
        Provider.of<AppService>(context, listen: false);
    _appService.selectedChatRoomID = int.parse(this.roomID!);
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
