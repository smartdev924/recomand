import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:provider/provider.dart';
import 'package:localservice/services/AppService.dart';
import 'package:quick_actions/quick_actions.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AppService _appService;
  QuickActions quickActions = const QuickActions();

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
  }

  initializeQuickActions(BuildContext context) {
    quickActions.initialize((String shortcutType) {
      switch (shortcutType) {
        case 'client':
          return;
        case 'provider':
          return;
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
          type: 'client',
          localizedTitle: Languages.of(context)!.clientMode,
          icon: "launcher_icon"),
      ShortcutItem(
          type: 'provider',
          localizedTitle: Languages.of(context)!.providerMode,
          icon: "launcher_icon"),
    ]);
  }

  Future<void> executeAfterBuild(BuildContext context) async {
    await Future.delayed(Duration.zero);
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
      initializeQuickActions(context);
  }

  @override
  Widget build(BuildContext context) {
    _appService.contextData = context;
    executeAfterBuild(context);

    return SafeArea(
      child: Center(
          child: Image.asset(
        "assets/images/local_services.png",
        fit: BoxFit.contain,
        height: double.infinity,
      )),
    );
  }
}
