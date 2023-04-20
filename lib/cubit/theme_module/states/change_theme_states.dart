import 'package:flutter/material.dart';
import 'package:localservice/theme/base_theme.dart';
import 'package:localservice/theme/enum.dart';

class ChangeThemeState {
  final ThemeData themeData;
  final ThemeType type;
  bool? isDarkTheme;
  final Map<String, Color> customColors;
  dynamic selectedSubCategory;
  dynamic selectedProduct;
  dynamic testValue;
  dynamic userData;

  ChangeThemeState({
    required this.themeData,
    required this.type,
    required this.customColors,
  }) {
    isDarkTheme = themeData.brightness == Brightness.dark;
    selectedSubCategory = null;
    selectedProduct = null;
    userData = null;
  }
  static ChangeThemeState? of(BuildContext context) {
    return Localizations.of<ChangeThemeState>(context, ChangeThemeState);
  }

  factory ChangeThemeState.lightTheme({required ThemeType type}) {
    return ChangeThemeState(
      themeData: getModuleLightTheme(),
      customColors: getLightThemeCustomColors(),
      type: type,
    );
  }
  Future<void> changeSelectedSubCategory(dynamic category) async {
    selectedSubCategory = category;
  }

  Future<void> changeSelectedProduct(
      BuildContext context, dynamic product) async {
    selectedProduct = product;
  }

  Future<void> setUserData(BuildContext context, dynamic userData) async {
    userData = userData;
  }

  factory ChangeThemeState.darkTheme({required ThemeType type}) {
    return ChangeThemeState(
      themeData: getModuleDarkTheme(),
      customColors: getDarkThemeCustomColors(),
      type: type,
    );
  }
}
