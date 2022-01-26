import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BillEditToggle extends StatelessWidget {
  const BillEditToggle({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final AsyncCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      right: 0,
      bottom: 15,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomLeft: Radius.circular(35),
              )),
          padding: const EdgeInsets.only(left: 12, right: 8, top: 6, bottom: 6),
          child: const Icon(
            Icons.edit,
            color: Colors.black,
            size: 24,
          ),
        ),
      ),
    );
  }
}
