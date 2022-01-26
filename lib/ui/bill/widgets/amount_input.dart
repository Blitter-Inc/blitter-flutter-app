import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInput extends StatelessWidget {
  const AmountInput({
    Key? key,
    required this.controller,
    required this.enabled,
  }) : super(key: key);

  final TextEditingController controller;
  final bool enabled;

  void _incrementAmount(double value) {
    controller.text =
        (double.parse(controller.text) + value).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        TextFormField(
          controller: controller,
          enabled: enabled,
          style: TextStyle(
            color: colorScheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            suffixText: enabled ? '' : '/~',
            labelText: 'Amount',
            prefixText: '₹  ',
            prefixStyle: TextStyle(
              color: colorScheme.primary,
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
        ),
        if (enabled) ...[
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () => _incrementAmount(100),
                  child: const Text('+100'),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () => _incrementAmount(500),
                  child: const Text('+500'),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () => _incrementAmount(1000),
                  child: const Text('+1000'),
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }
}
