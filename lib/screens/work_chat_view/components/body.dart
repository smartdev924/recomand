import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localservice/screens/work_chat_view/components/work_chat_widget_web.dart';
import 'work_chat_widget.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: kIsWeb ? WorkChatWidgetWeb() : WorkChatWidget(),
      ),
    );
  }
}
