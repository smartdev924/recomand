import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localservice/screens/direct_chat_view/components/direct_chat_widget.dart';
import 'package:localservice/screens/direct_chat_view/components/direct_chat_widget_web.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: kIsWeb ? DirectChatWidgetWeb() : DirectChatWidget(),
      ),
    );
  }
}
