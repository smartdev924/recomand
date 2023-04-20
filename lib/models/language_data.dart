// import 'package:localservice/localization/locale_constant.dart';

class LanguageData {
  final String flag;
  final String name;
  final String languageCode;

  LanguageData(this.flag, this.name, this.languageCode);

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData("🇺🇸", "English", 'en'),
      LanguageData("🇷🇴", "Română", "ro"),
      LanguageData("🇮🇹", "Italiano", "it"),
      LanguageData("🇪🇸", "Español", "es"),
      LanguageData("🇫🇷", "Français", "fr"),
      LanguageData("🇷🇺", "Русский", "ru"),
      LanguageData("🇩🇪", "Deutsch", "de"),
    ];
  }
}
