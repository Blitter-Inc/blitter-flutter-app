import 'package:flutter/material.dart';

class BillTypeBadge extends StatelessWidget {
  const BillTypeBadge({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: 12,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            bottomLeft: Radius.circular(35),
          ),
        ),
        height: 30,
        padding: const EdgeInsets.only(right: 5, left: 10),
        // width: 50,
        child: Center(
          child: Text(
            type.toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
