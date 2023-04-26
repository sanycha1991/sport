import 'package:sport/extensions/imports.dart';

class LanguageConfig {
  static const defaultLanguage = 'en';
  static const defaultLocale = Locale(defaultLanguage);
  static const suppoertedLanguages = [
    'en',
  ];

  // ignore: non_constant_identifier_names
  static List<Locale> get supportedLocales {
    return [
      const Locale('en'),
    ];
  }
}
