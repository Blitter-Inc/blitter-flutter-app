import 'package:flutter/material.dart';

const List<Color> defaultGradients = [
  Colors.teal,
  Colors.lightGreen,
  Colors.lime,
];

final foregroundShader = const LinearGradient(
  colors: defaultGradients,
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
