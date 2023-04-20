import 'package:flutter/material.dart';
import './chat_widget.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ChatWidget(),
      ),
    );
  }
}
