import 'package:flutter/material.dart';
import 'package:localservice/main.dart';
import 'package:localservice/theme/theme_colors.dart';

import 'base_theme.dart';
// import 'theme_colors.dart';

class AppDarkTheme extends BaseTheme {
  static final AppDarkTheme _instance = AppDarkTheme._();

  AppDarkTheme._();

  factory AppDarkTheme() => _instance;

  @override
  Color get primaryColor => Color.fromARGB(255, 0, 0, 0);

  @override
  Color get accentColor => LightThemeColors.accentColor;

  @override
  Brightness get brightness => Brightness.dark;

  @override
  ThemeData get darkTheme {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: Color.fromRGBO(43, 44, 46, 1),
      appBarTheme: AppBarTheme(
          color: Color.fromRGBO(40, 42, 45, 1),
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(color: Color.fromRGBO(212, 212, 212, 1)),
          iconTheme: IconThemeData(color: Color.fromRGBO(212, 212, 212, 1))),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: NoAnimationPageTransitionsBuilder(),
          TargetPlatform.windows: NoAnimationPageTransitionsBuilder(),
          TargetPlatform.iOS: NoAnimationPageTransitionsBuilder(),
          TargetPlatform.macOS: NoAnimationPageTransitionsBuilder(),
          TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
        },
      ),
    );
  }

  @override
  Color? get darkAccentColor => null;

  @override
  Color? get darkPrimaryColor => null;

  @override
  ThemeData? get lightTheme => null;

  /// This will use for custom colors which couldn't part of the theme data.
  @override
  Map<String, Color> get customColor => {
        AppColors.white: DarkThemeColors.black,
        AppColors.black: DarkThemeColors.white,
        AppColors.buttonTextColor: DarkThemeColors.buttonTextColor,
        AppColors.bottomNavigationBarColor:
            DarkThemeColors.bottomNavigationBarColor,
        AppColors.bottomNavigationIconInActiveColor:
            DarkThemeColors.bottomNavigationIconInActiveColor,
        AppColors.bottomNavigationIconActiveColor:
            DarkThemeColors.bottomNavigationIconActiveColor,
        AppColors.primaryBackgroundColor:
            DarkThemeColors.primaryBackgroundColor,
        AppColors.primaryButtonColor: DarkThemeColors.primaryButtonColor,
        AppColors.secondaryButtonColor: DarkThemeColors.secondaryButtonColor,
        AppColors.SloganColor: DarkThemeColors.SloganColor,
        AppColors.loadingIndicatorBackgroundColor:
            DarkThemeColors.loadingIndicatorBackgroundColor,
        AppColors.loadingIndicatorColor: DarkThemeColors.loadingIndicatorColor,
        AppColors.secondaryButtonTextColor:
            DarkThemeColors.secondaryButtonTextColor,
        AppColors.primaryTextColor1: DarkThemeColors.primaryTextColor1
      };
}
