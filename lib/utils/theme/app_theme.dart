import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasebak_app/res/app_colors.dart';

abstract class BaseAppTheme {
  ThemeData get themeDataLight;
  TextTheme get txtThemeLight;
  ThemeData get themeDataDark;
  TextTheme get txtThemeDark;
}

class LightAppTheme implements BaseAppTheme {
  /// The Light Theme
  @override
  ThemeData get themeDataLight {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      textTheme: txtThemeLight,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.colorSchemeSeed,
        primary: AppColors.colorPrimary,
      ),
      primaryColor: AppColors.colorPrimary,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      iconTheme: ThemeData.light(
        useMaterial3: false,
      ).iconTheme.copyWith(color: AppColors.iconTheme),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColors.floatActionBtnforegroundColor,
        backgroundColor: AppColors.floatActionBtnBackgroundColor,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.bottomNavigationBarBackground,
      ),
      cardTheme: ThemeData.light().cardTheme.copyWith(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
        ),
        iconTheme: ThemeData.light(
          useMaterial3: false,
        ).iconTheme.copyWith(color: AppColors.appBarIconColor),
        titleTextStyle: txtThemeLight.titleMedium?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.appBarTextColor,
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.appBarBackground,
      ),
    );
  }

  @override
  TextTheme get txtThemeLight => ThemeData.light()
      .copyWith(textTheme: GoogleFonts.cairoTextTheme())
      .textTheme
      .copyWith(
        // Sherpa Blue
        headlineMedium: GoogleFonts.tajawal().copyWith(
          color: AppColors.headlineMedium,
        ),

        // Silver
        bodySmall: GoogleFonts.tajawal().copyWith(color: AppColors.bodySmall),

        ///Gray
        titleSmall: GoogleFonts.tajawal().copyWith(color: AppColors.titleSmall),

        /// jaffa
        bodyMedium: GoogleFonts.tajawal().copyWith(color: AppColors.bodyMedium),

        /// white
        bodyLarge: GoogleFonts.tajawal().copyWith(color: AppColors.bodyLarge),

        /// black
        titleMedium: GoogleFonts.tajawal().copyWith(
          color: AppColors.titleMedium,
        ),

        /// dusty gray
        headlineSmall: GoogleFonts.tajawal().copyWith(
          color: AppColors.headlineSmall,
        ),

        /// mine shaft
        headlineLarge: GoogleFonts.tajawal().copyWith(
          color: AppColors.headlineLarge,
        ),

        // alto2
        labelSmall: GoogleFonts.tajawal().copyWith(color: AppColors.labelSmall),

        // amaranth
        displaySmall: GoogleFonts.tajawal().copyWith(
          color: AppColors.displaySmall,
        ),
      );

  @override
  ThemeData get themeDataDark => themeDataLight;

  @override
  TextTheme get txtThemeDark => txtThemeLight;

  String get fontFamily => "Tajawal";
}
