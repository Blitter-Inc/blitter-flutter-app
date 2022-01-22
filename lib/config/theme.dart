import 'package:flutter/material.dart';

import './color.dart';

ThemeData generateThemeDataFromPalette({
  required ThemeData themeData,
  required ColorScheme colorScheme,
  required ThemeColorPalette palette,
  required Color primary,
}) {
  return themeData.copyWith(
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: TextStyle(
        color: palette.snackBarContentTextColor,
      ),
      backgroundColor: palette.snackBarBackgroundColor,
    ),
    colorScheme: colorScheme.copyWith(
      primary: primary,
    ),
    scaffoldBackgroundColor: palette.scaffoldBackgroundColor,
    cardColor: palette.cardColor,
    bottomSheetTheme: themeData.bottomSheetTheme.copyWith(
      modalBackgroundColor: palette.bottomSheetModalBackgroundColor,
    ),
    appBarTheme: themeData.appBarTheme.copyWith(
      elevation: 0,
      foregroundColor: palette.appBarForegroundColor,
      backgroundColor: palette.appBarBackgroundColor,
    ),
  );
}

ThemeData generateModuleThemeData({
  required ThemeData defaultThemeData,
  required Color modulePrimaryColor,
}) {
  return defaultThemeData.copyWith(
    colorScheme: defaultThemeData.colorScheme.copyWith(
      primary: modulePrimaryColor,
    ),
    appBarTheme: defaultThemeData.appBarTheme.copyWith(
      foregroundColor: modulePrimaryColor,
    ),
    snackBarTheme: defaultThemeData.snackBarTheme.copyWith(
      backgroundColor: modulePrimaryColor,
    ),
  );
}
