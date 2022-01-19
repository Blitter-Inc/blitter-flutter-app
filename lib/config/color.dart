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
