import 'package:flutter/material.dart';

import './color.dart';

final lightColorPalette = LightThemeColorPalette();
final darkColorPalette = DarkThemeColorPalette();

final lightThemeData = generateThemeDataFromPalette(
  themeData: ThemeData.light(),
  colorScheme: const ColorScheme.light(),
  palette: lightColorPalette,
);

final darkThemeData = generateThemeDataFromPalette(
  themeData: ThemeData.dark(),
  colorScheme: const ColorScheme.dark(),
  palette: darkColorPalette,
);

ThemeData generateThemeDataFromPalette({
  required ThemeData themeData,
  required ColorScheme colorScheme,
  required ThemeColorPalette palette,
}) {
  return themeData.copyWith(
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: TextStyle(
        color: palette.snackBarContentTextColor,
      ),
      backgroundColor: palette.snackBarBackgroundColor,
    ),
    colorScheme: colorScheme.copyWith(
      primary: primaryColor,
      primaryVariant: primaryVariantColor,
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
      foregroundColor: primaryColor,
    ),
    snackBarTheme: defaultThemeData.snackBarTheme.copyWith(
      backgroundColor: modulePrimaryColor,
    ),
  );
}

extension CustomColorScheme on ColorScheme {
  // ColorScheme get object => this;

  bool get _darkThemeEnabled => brightness == Brightness.dark;

  Color get cardText => _darkThemeEnabled
      ? darkColorPalette.cardTextColor
      : lightColorPalette.cardTextColor;

  Color get cardSubtext => _darkThemeEnabled
      ? darkColorPalette.cardSubtextColor
      : lightColorPalette.cardSubtextColor;

  Color get bottomSheetModalBackground => _darkThemeEnabled
      ? darkColorPalette.bottomSheetModalBackgroundColor
      : lightColorPalette.bottomSheetModalBackgroundColor;

  Color get cupertinoPickerItemText => _darkThemeEnabled
      ? darkColorPalette.cupertinoPickerItemTextColor
      : lightColorPalette.cupertinoPickerItemTextColor;
}
