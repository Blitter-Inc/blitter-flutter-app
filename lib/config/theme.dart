import 'package:flutter/material.dart';

import './color.dart';

ThemeData lightThemeData = ThemeData.light().copyWith(
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
);

ThemeData darkThemeData = ThemeData.dark().copyWith(
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
);

extension CustomColorScheme on ColorScheme {
  Color get billPrimaryColor => Colors.teal;
}

extension BillColorScheme on ColorScheme {
  bool get _darkThemeEnabled => brightness == Brightness.dark;

  Color get billCardText {
    return _darkThemeEnabled
        ? const Color.fromRGBO(200, 200, 200, 1)
        : const Color.fromRGBO(55, 55, 55, 1);
  }

  Color get billCardSubtext {
    return _darkThemeEnabled ? Colors.white60 : Colors.black54;
  }
}
