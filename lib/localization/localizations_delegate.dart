import 'package:flutter/material.dart';
import 'package:localservice/localization/language/language_en.dart';
import 'package:localservice/localization/language/language_es.dart';
import 'package:localservice/localization/language/language_ro.dart';
import 'package:localservice/localization/language/language_it.dart';
import 'package:localservice/localization/language/language_fr.dart';
import 'package:localservice/localization/language/language_de.dart';
import 'package:localservice/localization/language/language_ru.dart';

import 'language/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ro', 'it', 'es', 'fr', 'de', 'ru'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ro':
        return LanguageRo();
      case 'it':
        return LanguageIt();
      case 'es':
        return LanguageEs();
      case 'fr':
        return LanguageFr();
      case 'de':
        return LanguageDe();
      case 'ru':
        return LanguageRu();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
