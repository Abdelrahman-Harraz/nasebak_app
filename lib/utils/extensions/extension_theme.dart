import 'package:flutter/material.dart';

extension ThemesValuesExtension on BuildContext {
  ThemeData get _themeData => Theme.of(this);

  TextStyle? get displayLarge => _themeData.textTheme.displayLarge;
  TextStyle? get displayMedium => _themeData.textTheme.displayMedium;
  TextStyle? get displaySmall => _themeData.textTheme.displaySmall;

  /// Headline styles are smaller than display styles.
  /// They're best-suited for short, high-emphasis text on smaller screens.
  TextStyle? get headlineLarge => _themeData.textTheme.headlineLarge;
  TextStyle? get headlineMedium => _themeData.textTheme.headlineMedium;
  TextStyle? get headlineSmall => _themeData.textTheme.headlineSmall;

  /// Titles are smaller than headline styles
  /// and should be used for shorter, medium-emphasis text.
  TextStyle? get titleLarge => _themeData.textTheme.titleLarge;
  TextStyle? get titleMedium => _themeData.textTheme.titleMedium;
  TextStyle? get titleSmall => _themeData.textTheme.titleSmall;

  TextStyle? get bodyLarge => _themeData.textTheme.bodyLarge;
  TextStyle? get bodyMedium => _themeData.textTheme.bodyMedium;
  TextStyle? get bodySmall => _themeData.textTheme.bodySmall;
}
