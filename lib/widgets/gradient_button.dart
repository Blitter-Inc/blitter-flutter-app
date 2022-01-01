import 'package:flutter/material.dart';

import '../constants/color.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const GradientButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 36,
        ),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 25,
              spreadRadius: 25,
            )
          ],
          gradient: LinearGradient(
            colors: defaultGradients,
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(title),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
