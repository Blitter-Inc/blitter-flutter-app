import 'package:flutter/material.dart';

import './color.dart';

final defaultLightThemeData = ThemeData.light();
final defaultDarkThemeData = ThemeData.dark();

ThemeData lightThemeData = defaultLightThemeData.copyWith(
  snackBarTheme: const SnackBarThemeData(
    contentTextStyle: TextStyle(
      color: Colors.black,
    ),
    backgroundColor: primaryColor,
  ),
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    primaryVariant: primaryVariantColor,
  ),
  cardColor: const Color.fromRGBO(215, 215, 215, 1),
  bottomSheetTheme: defaultLightThemeData.bottomSheetTheme.copyWith(
    modalBackgroundColor: const Color.fromRGBO(215, 215, 215, 1),
  ),
);

ThemeData darkThemeData = defaultDarkThemeData.copyWith(
  snackBarTheme: const SnackBarThemeData(
    contentTextStyle: TextStyle(
      color: Colors.black,
    ),
    backgroundColor: primaryColor,
  ),
  colorScheme: const ColorScheme.dark(
    primary: primaryColor,
    primaryVariant: primaryVariantColor,
  ),
  scaffoldBackgroundColor: Colors.black,
  cardColor: const Color.fromRGBO(30, 30, 30, 1),
  bottomSheetTheme: defaultDarkThemeData.bottomSheetTheme.copyWith(
    modalBackgroundColor: const Color.fromRGBO(30, 30, 30, 1),
  ),
);

extension CustomColorScheme on ColorScheme {
  // ColorScheme get object => this;

  bool get _darkThemeEnabled => brightness == Brightness.dark;

  Color get cardText => _darkThemeEnabled
      ? const Color.fromRGBO(200, 200, 200, 1)
      : const Color.fromRGBO(55, 55, 55, 1);

  Color get cardSubtext => _darkThemeEnabled ? Colors.white60 : Colors.black54;

  Color get cardBackground => _darkThemeEnabled
      ? const Color.fromRGBO(30, 30, 30, 1)
      : const Color.fromRGBO(215, 215, 215, 1);

  Color get cupertinoPickerItemText => _darkThemeEnabled
      ? const Color.fromRGBO(200, 200, 200, 1)
      : const Color.fromRGBO(55, 55, 55, 1);
}

extension BillContext on BuildContext {
  Color get primaryColor => Colors.indigoAccent;
}
