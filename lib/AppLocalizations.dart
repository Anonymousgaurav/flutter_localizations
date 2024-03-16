import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppLocalizations {
  final Locale locale;
  late Map<String, String> _translations;
  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale("en"),
    Locale("es"),
    Locale("ca", "ES")
  ];

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    final res = Localizations.of<AppLocalizations>(context, AppLocalizations);
    if (res != null) {
      return res;
    } else {
      throw Exception(
          "This widget should be child of material widget with localization");
    }
  }

  Future<bool> load() async {
    var strJson =
    await rootBundle.loadString("i18n/${locale.languageCode}.json");

    Map<String, dynamic> pairs = jsonDecode(strJson);

    _translations = pairs.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    if (_translations.containsKey(key)) {
      return _translations[key] ?? key;
    }
    return key;
  }
}


class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations loc = AppLocalizations(locale);

    await loc.load();

    return loc;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
