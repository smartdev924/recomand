import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localservice/screens/chat_view/components/chat_widget_web.dart';
import './chat_widget.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: kIsWeb ? ChatWidgetWeb() : ChatWidget(),
      ),
    );
  }
}
