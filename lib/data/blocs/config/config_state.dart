import 'package:flutter/material.dart';

import 'package:blitter_flutter_app/config.dart' as default_app_config;

class ConfigState {
  final bool darkModeEnabled;
  final Color primaryColor;
  final Color billPrimaryColor;

  const ConfigState({
    this.darkModeEnabled = true,
    this.primaryColor = default_app_config.primaryColor,
    this.billPrimaryColor = default_app_config.ModuleColorPalette.bill,
  });

  ConfigState.fromJson(Map<String, dynamic> json)
      : darkModeEnabled = json['darkModeEnabled'],
        primaryColor = Color(json['colorPalette']['primary']),
        billPrimaryColor = Color(json['colorPalette']['billPrimary']);

  Map<String, dynamic> toJson() => {
        'darkModeEnabled': darkModeEnabled,
        'colorPalette': {
          'primary': primaryColor.value,
          'billPrimary': billPrimaryColor.value,
        },
      };

  ConfigState copyWith({
    bool? darkModeEnabled,
    Color? primaryColor,
    Color? billPrimaryColor,
  }) =>
      ConfigState(
        darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
        primaryColor: primaryColor ?? this.primaryColor,
        billPrimaryColor: billPrimaryColor ?? this.billPrimaryColor,
      );
}
