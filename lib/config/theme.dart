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
      secondary: primary,
    ),
    scaffoldBackgroundColor: palette.scaffoldBackgroundColor,
    cardColor: palette.cardColor,
    bottomSheetTheme: themeData.bottomSheetTheme.copyWith(
      modalBackgroundColor: palette.bottomSheetModalBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
    ),
    appBarTheme: themeData.appBarTheme.copyWith(
      elevation: 0,
      foregroundColor: palette.appBarForegroundColor,
      backgroundColor: palette.appBarBackgroundColor,
      shadowColor: palette.appBarShadowColor,
    ),
    chipTheme: themeData.chipTheme.copyWith(
      selectedColor: primary,
      checkmarkColor: Colors.black,
      labelStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
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
      secondary: modulePrimaryColor,
    ),
    appBarTheme: defaultThemeData.appBarTheme.copyWith(
      foregroundColor: modulePrimaryColor,
    ),
    snackBarTheme: defaultThemeData.snackBarTheme.copyWith(
      backgroundColor: modulePrimaryColor,
    ),
  );
}
