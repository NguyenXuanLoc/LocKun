// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:convert';
import 'dart:ui';

import 'package:base_bloc/utils/log_utils.dart';
import 'package:easy_localization/easy_localization.dart' show AssetLoader;
import 'package:flutter/services.dart';

class Applocalizations extends AssetLoader {
  const Applocalizations();

  static const enCode = 'en';
  static const plCode = 'pl';
  static const ruCode = 'ru';
  static const uaCode = 'uk';
  static const deCode = 'de';

  static const languageCode = {
    enCode: 'eng',
    plCode: plCode,
    deCode: deCode,
    ruCode: ruCode,
    uaCode: 'ua'
  };

  static const localeEn = Locale(enCode);
  static const localePl = Locale(plCode);
  static const localeRu = Locale(ruCode);
  static const localeUa = Locale(uaCode);
  static const localeDe = Locale(deCode);

  static const List<Locale> supportedLocales = <Locale>[
    localeEn,
    localePl,
    localeRu,
    localeUa,
    localeDe
  ];

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) async {
    var locales = await getLocales();
    return Future.value(locales[locale.toString()]);
  }

  Future<Map<String, dynamic>> getLanguage(String fileName) async {
    String str = await rootBundle.loadString('assets/translations/$fileName.json');
    return json.decode(str);
  }

  Future<Map<String, Map<String, dynamic>>> getLocales() async {
    var englishLanguage = await getLanguage(enCode);
    var polishLanguage = await getLanguage(plCode);
    var germanyLanguage = await getLanguage(deCode);
    var russianLanguage = await getLanguage(ruCode);
    var ukraineLanguage = await getLanguage(uaCode);
    return {
      enCode: englishLanguage,
      plCode: polishLanguage,
      uaCode: ukraineLanguage,
      ruCode: russianLanguage,
      deCode: germanyLanguage
    };
  }

}
