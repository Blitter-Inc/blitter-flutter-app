import 'package:flutter/material.dart';

class DescriptionInput extends StatelessWidget {
  const DescriptionInput({
    Key? key,
    required this.controller,
    required this.enabled,
  }) : super(key: key);

  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: controller,
      enabled: enabled,
      textCapitalization: TextCapitalization.sentences,
      maxLines: 3,
      style: TextStyle(
        color: colorScheme.primary,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.white54,
            style: BorderStyle.solid,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            width: 2,
            color: colorScheme.primary,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
