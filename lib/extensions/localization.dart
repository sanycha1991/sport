import 'package:sport/extensions/config.dart';
import 'package:sport/extensions/imports.dart';
import 'package:sport/languages/lang_data.dart';

class AppLocalizations {
  final Locale locale;

  late Map _localizedStrings;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Future<bool> load() async {
    try {
      Map<dynamic, dynamic> langs = languages;

      localizedStrings = langs[locale.languageCode];
      return true;
    } catch (e) {
      // dd('AppLocalizations load $e');
      return false;
    }
  }

  set localizedStrings(Map langs) {
    _localizedStrings = langs.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) {
    if (_localizedStrings[key] == null) return key;
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return LanguageConfig.suppoertedLanguages.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
