import 'package:flutter/material.dart';

class BillNameInput extends StatelessWidget {
  const BillNameInput({
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
      decoration: const InputDecoration(
        labelText: 'Enter bill name',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: colorScheme.primary,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
