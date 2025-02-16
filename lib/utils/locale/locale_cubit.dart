import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasebak_app/preferences/preferences_manager.dart';
import 'package:nasebak_app/utils/locale/app_localization.dart';

class LocaleCubit extends Cubit<Locale> {
  final PreferencesManager preferenceManager;

  LocaleCubit(this.preferenceManager) : super(LocaleApp.ar.toLocale()) {
    getDefaultLocale();
  }

  void changeLocale(LocaleApp selectedLanguage) async {
    final defaultLanguageCode = await preferenceManager.getLocale();

    if (selectedLanguage == LocaleApp.ar && defaultLanguageCode != codeArSA) {
      emit(LocaleApp.ar.toLocale());
      await preferenceManager.setLocale(selectedLanguage.mapToPreferenceKey());
    } else if (selectedLanguage == LocaleApp.en &&
        defaultLanguageCode != codeArSA) {
      emit(LocaleApp.en.toLocale());
      await preferenceManager.setLocale(selectedLanguage.mapToPreferenceKey());
    }
  }

  void getDefaultLocale() async {
    final defaultLanguageCode = await preferenceManager.getLocale();
    // const defaultLanguageCode = null;
    Locale locale;
    if (defaultLanguageCode == null) {
      locale = defaultSystemLocale;
      await preferenceManager.setLocale(
        LocaleApp.mapFromString(locale.languageCode).mapToPreferenceKey(),
      );
    } else {
      if (defaultLanguageCode == codeEn) {
        locale = LocaleApp.en.toLocale();
        Locale(defaultLanguageCode);
        await preferenceManager.setLocale(
          LocaleApp.mapFromString(locale.languageCode).mapToPreferenceKey(),
        );
      } else {
        locale = LocaleApp.ar.toLocale();
        await preferenceManager.setLocale(
          LocaleApp.mapFromString(locale.languageCode).mapToPreferenceKey(),
        );
      }
    }
    emit(locale);
  }

  // String get defaultSystemLocale => Platform.localeName.substring(0, 2);
  Locale get defaultSystemLocale => LocaleApp.ar.toLocale();
}

enum LocaleApp {
  en,
  ar;

  String mapToApiKey() {
    switch (this) {
      case LocaleApp.en:
        return codeEnUS;
      case LocaleApp.ar:
        return codeArSA;
    }
  }

  Locale toLocale() {
    switch (this) {
      case LocaleApp.en:
        return const Locale(codeEn, codeUs);

      case LocaleApp.ar:
        return const Locale(codeAr, codeSa);
    }
  }

  static LocaleApp mapFromString(String languageCode) {
    switch (languageCode) {
      case codeEn:
        return LocaleApp.en;
      case codeAr:
        return LocaleApp.ar;
      default:
        return LocaleApp.ar;
    }
  }

  String mapToPreferenceKey() {
    switch (this) {
      case LocaleApp.en:
        return codeEn;
      case LocaleApp.ar:
        return codeAr;
    }
  }
}
