import 'package:flutter/material.dart';

class BillNameInput extends StatelessWidget {
  const BillNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
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
