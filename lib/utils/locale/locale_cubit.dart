import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasebak_app/preferences/preferences_manager.dart';
import 'package:nasebak_app/utils/locale/app_localization.dart';

class LocaleCubit extends Cubit<Locale> {
  final PreferencesManager preferenceManager;

  LocaleCubit(this.preferenceManager) : super(const Locale(codeAr)) {
    getDefaultLocale();
  }

  void changeLocale(LocaleApp selectedLanguage) async {
    final defaultLanguageCode = await preferenceManager.getLocale();

    if (selectedLanguage == LocaleApp.ar && defaultLanguageCode != codeAr) {
      emit(const Locale(codeAr));
      await preferenceManager.setLocale(
        LocaleApp.mapFromString(codeAr).mapToPreferenceKey(),
      );
    } else if (selectedLanguage == LocaleApp.en &&
        defaultLanguageCode != codeEn) {
      emit(const Locale(codeEn));
      await preferenceManager.setLocale(
        LocaleApp.mapFromString(codeEn).mapToPreferenceKey(),
      );
    }
  }

  void getDefaultLocale() async {
    final defaultLanguageCode = await preferenceManager.getLocale();
    Locale locale;
    if (defaultLanguageCode == null) {
      locale = Locale(defaultSystemLocale);
      await preferenceManager.setLocale(
        LocaleApp.mapFromString(locale.languageCode).mapToPreferenceKey(),
      );
    } else {
      locale = Locale(defaultLanguageCode);
      if (locale.languageCode == codeEn) {
        await preferenceManager.setLocale(
          LocaleApp.mapFromString(locale.languageCode).mapToPreferenceKey(),
        );
      } else {
        await preferenceManager.setLocale(
          LocaleApp.mapFromString(locale.languageCode).mapToPreferenceKey(),
        );
      }
    }
    emit(locale);
  }

  // TODO: Set the default for now for the first time usre open the app is Arabic
  // instead of the device language
  //
  // import 'dart:io';
  //
  // String get defaultSystemLocale => Platform.localeName.substring(0, 2);
  String get defaultSystemLocale => LocaleApp.ar.name;
}

enum LocaleApp {
  en,
  ar;

  int mapToApiKey() {
    switch (this) {
      case LocaleApp.en:
        return 1;
      case LocaleApp.ar:
        return 2;
    }
  }

  static LocaleApp mapFromString(String languageCode) {
    switch (languageCode) {
      case "en":
        return LocaleApp.en;
      case "ar":
        return LocaleApp.ar;
      default:
        return LocaleApp.en;
    }
  }

  String mapToPreferenceKey() {
    switch (this) {
      case LocaleApp.en:
        return "$codeEn-$conUs";
      case LocaleApp.ar:
        return "$codeAr-$conSa";
    }
  }
}
