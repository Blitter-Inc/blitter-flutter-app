import 'package:flutter/material.dart';

class TranslucentTextFormFieldContainer extends StatelessWidget {
  final TextFormField child;
  final double paddingHorizontal;
  final double paddingVertical;

  const TranslucentTextFormFieldContainer({
    Key? key,
    required this.child,
    this.paddingHorizontal = 15,
    this.paddingVertical = 0,
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
        padding: EdgeInsets.only(left: paddingHorizontal, right: paddingHorizontal, bottom: paddingVertical),
        child: child,
      ),
    );
  }
}
