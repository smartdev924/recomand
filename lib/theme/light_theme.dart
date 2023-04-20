import 'package:flutter/material.dart';
import 'package:localservice/theme/theme_colors.dart';
import 'base_theme.dart';
import 'package:localservice/main.dart';

class AppLightTheme extends BaseTheme {
  static final AppLightTheme _instance = AppLightTheme._();

  AppLightTheme._();

  factory AppLightTheme() => _instance;

  @override
  Color get primaryColor => Color.fromARGB(255, 245, 78, 0);

  @override
  Color get accentColor => LightThemeColors.accentColor;

  @override
  Brightness get brightness => Brightness.light;

  @override
  ThemeData get lightTheme {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
        brightness: brightness,
        scaffoldBackgroundColor: Color.fromRGBO(245, 245, 245, 1),
        appBarTheme: AppBarTheme(
            color: Colors.white,
            shadowColor: Colors.transparent,
            titleTextStyle: TextStyle(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black)),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: NoAnimationPageTransitionsBuilder(),
            TargetPlatform.windows: NoAnimationPageTransitionsBuilder(),
            TargetPlatform.iOS: NoAnimationPageTransitionsBuilder(),
            TargetPlatform.macOS: NoAnimationPageTransitionsBuilder(),
            TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
          },
        ));
  }

  @override
  Color? get darkAccentColor => null;

  @override
  Color? get darkPrimaryColor => null;

  @override
  ThemeData? get darkTheme => null;

  /// This will use for custom colors which couldn't part of the theme data.
  @override
  Map<String, Color> get customColor => {
        AppColors.white: LightThemeColors.white,
        AppColors.black: LightThemeColors.black,
        AppColors.buttonTextColor: LightThemeColors.buttonTextColor,
        AppColors.bottomNavigationBarColor:
            LightThemeColors.bottomNavigationBarColor,
        AppColors.bottomNavigationIconInActiveColor:
            LightThemeColors.bottomNavigationIconInActiveColor,
        AppColors.bottomNavigationIconActiveColor:
            LightThemeColors.bottomNavigationIconActiveColor,
        AppColors.primaryButtonColor: LightThemeColors.primaryButtonColor,
        AppColors.secondaryButtonColor: LightThemeColors.secondaryButtonColor,
        AppColors.primaryBackgroundColor:
            LightThemeColors.primaryBackgroundColor,
        AppColors.loadingIndicatorBackgroundColor:
            LightThemeColors.loadingIndicatorBackgroundColor,
        AppColors.loadingIndicatorColor: LightThemeColors.loadingIndicatorColor,
        AppColors.SloganColor: LightThemeColors.SloganColor,
        AppColors.secondaryButtonTextColor:
            LightThemeColors.secondaryButtonTextColor,
        AppColors.primaryTextColor1: LightThemeColors.primaryTextColor1
      };
}
