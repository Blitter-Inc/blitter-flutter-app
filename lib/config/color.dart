import 'package:flutter/material.dart';

const primaryColor = Colors.lightGreen;
const primaryVariantColor = Colors.teal;

const List<Color> defaultGradients = [
  primaryVariantColor,
  primaryColor,
  Colors.lime,
];

final foregroundShader = const LinearGradient(
  colors: defaultGradients,
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

abstract class ThemeColorPalette {
  Color get cardColor;
  Color get cardTextColor;
  Color get cardSubtextColor;
  Color get modalBackgroundColor;
  Color get appBarForegroundColor;
  Color get appBarBackgroundColor;
  Color get appBarShadowColor;
  Color get snackBarContentTextColor;
  Color get snackBarBackgroundColor;
  Color get scaffoldBackgroundColor;
  Color get cupertinoPickerItemTextColor;
}

class LightThemeColorPalette implements ThemeColorPalette {
  @override
  Color get cardColor => const Color.fromRGBO(235, 235, 235, 1);

  @override
  Color get cardTextColor => const Color.fromRGBO(55, 55, 55, 1);

  @override
  Color get cardSubtextColor => Colors.black54;

  @override
  Color get modalBackgroundColor => const Color.fromRGBO(235, 235, 235, 1);

  @override
  Color get appBarForegroundColor => Colors.black;

  @override
  Color get appBarBackgroundColor => Colors.grey[50]!;

  @override
  Color get appBarShadowColor => Colors.black;

  @override
  Color get snackBarContentTextColor => Colors.black;

  @override
  Color get snackBarBackgroundColor => primaryColor;

  @override
  Color get scaffoldBackgroundColor => Colors.grey[50]!;

  @override
  Color get cupertinoPickerItemTextColor => const Color.fromRGBO(55, 55, 55, 1);
}

class DarkThemeColorPalette implements ThemeColorPalette {
  @override
  Color get cardColor => const Color.fromRGBO(30, 30, 30, 1);

  @override
  Color get cardTextColor => const Color.fromRGBO(200, 200, 200, 1);

  @override
  Color get cardSubtextColor => Colors.white60;

  @override
  Color get modalBackgroundColor => const Color.fromRGBO(30, 30, 30, 1);

  @override
  Color get appBarForegroundColor => Colors.white;

  @override
  Color get appBarBackgroundColor => Colors.black;

  @override
  Color get appBarShadowColor => Colors.white24;

  @override
  Color get snackBarContentTextColor => Colors.black;

  @override
  Color get snackBarBackgroundColor => primaryColor;

  @override
  Color get scaffoldBackgroundColor => Colors.black;

  @override
  Color get cupertinoPickerItemTextColor =>
      const Color.fromRGBO(200, 200, 200, 1);
}

class ModuleColorPalette {
  static const bill = primaryColor;
}
