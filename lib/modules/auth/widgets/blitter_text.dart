import 'package:flutter/material.dart';

import '../../../constants/color.dart';

class BlitterText extends StatelessWidget {
  const BlitterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Blitter',
          style: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
            foreground: Paint()..shader = foregroundShader,
          ),
        ),
        Text(
          'The All-In-One bill splitter app',
          style: TextStyle(
            foreground: Paint()..shader = foregroundShader,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
