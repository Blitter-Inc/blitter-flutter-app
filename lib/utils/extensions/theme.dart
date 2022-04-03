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

  Color get modalBackground => _darkThemeEnabled
      ? darkColorPalette.modalBackgroundColor
      : lightColorPalette.modalBackgroundColor;

  Color get modalBackgroundSecondary =>
      _darkThemeEnabled ? Colors.grey[850]! : Colors.black26;

  Color get cupertinoPickerItemText => _darkThemeEnabled
      ? darkColorPalette.cupertinoPickerItemTextColor
      : lightColorPalette.cupertinoPickerItemTextColor;

  Color get progressBarContainer =>
      _darkThemeEnabled ? Colors.grey[850]! : Colors.black26;

  Color get progressBarEmptyText =>
      _darkThemeEnabled ? Colors.grey : Colors.grey.shade800;

  Color get disabledChipText => _darkThemeEnabled ? Colors.white : Colors.black;
}
