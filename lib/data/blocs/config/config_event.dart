import 'package:flutter/material.dart';

abstract class ConfigEvent {}

class SwitchThemeMode extends ConfigEvent {}

class SetPrimaryColor extends ConfigEvent {
  final Color color;

  SetPrimaryColor(this.color);
}

class SetBillPrimaryColor extends ConfigEvent {
  final Color color;

  SetBillPrimaryColor(this.color);
}

class ResetConfigBloc extends ConfigEvent {}
