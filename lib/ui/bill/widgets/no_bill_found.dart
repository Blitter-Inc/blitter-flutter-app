import 'package:flutter/material.dart';

class NoBillFound extends StatelessWidget {
  const NoBillFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text(
          'No Bills Found',
          style: TextStyle(
            color: colorScheme.primary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
