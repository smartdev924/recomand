import 'package:flutter/material.dart';

/// Define your light theme colors
class LightThemeColors {
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color primaryColor = Color.fromRGBO(43, 43, 43, 10);
  static const Color accentColor = Colors.cyanAccent;
  static const Color buttonTextColor = Colors.white;
  static const Color secondaryButtonTextColor = Color.fromRGBO(43, 43, 43, 1);
  // static const Color buttonTextColor = Color.fromRGBO(43, 43, 43, 1);
  static const Color bottomNavigationBarColor = Colors.white;
  static const Color bottomNavigationIconInActiveColor =
      Color.fromRGBO(57, 58, 60, 1);
  static const Color bottomNavigationIconActiveColor =
      Color.fromRGBO(79, 162, 219, 1);
  static const Color primaryButtonColor = Color.fromRGBO(79, 162, 219, 1);
  static const Color SloganColor = Colors.black;
  static const Color secondaryButtonColor = Color.fromRGBO(242, 243, 245, 1);
  static const Color primaryBackgroundColor = Colors.white;
  static const Color loadingIndicatorColor = Colors.black;
  static const Color loadingIndicatorBackgroundColor = Colors.white;
  static const Color primaryTextColor1 = Color.fromRGBO(26, 29, 31, 1);
}

/// Define your dark theme colors
class DarkThemeColors {
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color primaryColor = Color.fromRGBO(79, 162, 219, 1);
  static const Color SloganColor = Color.fromRGBO(79, 162, 219, 1);

  static const Color accentColor = Colors.deepOrangeAccent;
  static const Color buttonTextColor = Color.fromRGBO(43, 43, 43, 1);
  static const Color secondaryButtonTextColor =
      Color.fromRGBO(212, 212, 212, 1);
  static const Color bottomNavigationBarColor = Color.fromRGBO(57, 58, 60, 1);
  static const Color bottomNavigationIconInActiveColor =
      Color.fromRGBO(141, 142, 147, 1);
  static const Color bottomNavigationIconActiveColor =
      Color.fromRGBO(100, 174, 223, 1);
  static const Color primaryButtonColor = Color.fromRGBO(79, 162, 219, 1);
  static const Color secondaryButtonColor = Color.fromRGBO(24, 24, 24, 1);
  static const Color primaryBackgroundColor = Color.fromRGBO(43, 44, 46, 1);

  static const Color loadingIndicatorColor = Colors.white;
  static const Color loadingIndicatorBackgroundColor =
      Color.fromRGBO(43, 44, 46, 1);
  static const Color primaryTextColor1 = Color.fromRGBO(218, 218, 218, 1);
}

/// Define the key for color
/// This will be use to access the color in UI.
/// NOTE:- These key will be use for customColor map in AppLightTheme/AppDarkTheme class.
class AppColors {
  static const String black = "black";
  static const String white = "white";
  static const String buttonTextColor = "buttonTextColor";
  static const String secondaryButtonTextColor = "secondaryButtonTextColor";
  static const String bottomNavigationBarColor = "bottomNavigationBarColor";
  static const String bottomNavigationIconInActiveColor =
      "bottomNavigationIconInActiveColor";
  static const String bottomNavigationIconActiveColor =
      "bottomNavigationIconActiveColor";
  static const String primaryButtonColor = "primaryButtonColor";
  static const String secondaryButtonColor = "secondaryButtonColor";
  static const String primaryBackgroundColor = "primaryBackgroundColor";
  static const String SloganColor = "SloganColor";
  static const String loadingIndicatorColor = "loadingIndicatorColor";
  static const String loadingIndicatorBackgroundColor =
      "loadingIndicatorBackgroundColor";
  static const String primaryTextColor1 = "primaryTextColor1";
}
