import 'package:flutter/material.dart';

class TranslucentTextFormFieldContainer extends StatelessWidget {
  final TextFormField child;
  final double paddingHorizontal;

  const TranslucentTextFormFieldContainer({
    Key? key,
    required this.child,
    this.paddingHorizontal = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 325),
        decoration: const BoxDecoration(
          color: Colors.white10,
        ),
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: child,
      ),
    );
  }
}
