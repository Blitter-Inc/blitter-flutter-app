import 'package:flutter/material.dart';

class ExceptionUIHandler {
  final BuildContext context;

  const ExceptionUIHandler(this.context);

  void showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
