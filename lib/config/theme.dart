import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/ui/shared.dart';
import './color.dart';

final lightColorPalette = LightThemeColorPalette();
final darkColorPalette = DarkThemeColorPalette();

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

extension CustomBuildContext on BuildContext {
  void switchThemeMode() {
    final configBloc = read<ConfigBloc>();
    configBloc.add(SwitchThemeMode());
  }

  void showColorPickerSheet() {
    showModalBottomSheet(
      context: this,
      barrierColor: Colors.black87,
      backgroundColor: Colors.transparent,
      builder: (context) => const ColorPickerSheet(),
    );
  }
}
