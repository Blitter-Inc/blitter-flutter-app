import 'package:flutter/material.dart';

class OTPInputField extends StatelessWidget {
  final List<FocusNode> pinFocusNodes;
  final List<TextEditingController> pinEditingControllers;

  const OTPInputField({
    Key? key,
    required this.pinFocusNodes,
    required this.pinEditingControllers,
  }) : super(key: key);

  Widget _pinDigitContainer(int index) {
    var focusNode = pinFocusNodes[index];
    var controller = pinEditingControllers[index];

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: 40,
        decoration: const BoxDecoration(
          color: Colors.white10,
        ),
        padding: const EdgeInsets.only(left: 4, right: 2),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          onChanged: (digit) {
            if (digit.isEmpty) {
              if (index != 0) {
                focusNode.previousFocus();
              }
            } else {
              if (index != 5) {
                focusNode.nextFocus();
              }
            }
          },
          maxLength: 1,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: List.generate(6, (index) => _pinDigitContainer(index)),
      ),
    );
  }
}
