import 'package:flutter/material.dart';

import 'package:blitter_flutter_app/config.dart';

final lightColorPalette = LightThemeColorPalette();
final darkColorPalette = DarkThemeColorPalette();

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
