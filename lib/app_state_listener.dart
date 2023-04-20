import 'package:flutter/widgets.dart';

class AppStateListener extends WidgetsBindingObserver {
  bool _isInForeground = true;

  bool get isInForeground => _isInForeground;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _isInForeground = true;
        break;
      case AppLifecycleState.inactive:
        _isInForeground = false;
        break;
      case AppLifecycleState.paused:
        _isInForeground = false;
        break;
      case AppLifecycleState.detached:
        _isInForeground = false;
        break;
    }
  }

  @override
  void didChangeMetrics() {
    if (isInForeground) {
      // App was brought to the foreground
      // This will trigger even if the deep link parameters have not changed
    }
  }
}
