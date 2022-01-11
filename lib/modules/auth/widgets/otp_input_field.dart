import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/cubits.dart';

class OTPInputField extends StatelessWidget {
  final List<FocusNode> pinFocusNodes;
  final List<TextEditingController> pinEditingControllers;

  const OTPInputField({
    Key? key,
    required this.pinFocusNodes,
    required this.pinEditingControllers,
  }) : super(key: key);

  Widget _pinDigitContainer(int index, SigninCubit cubit) {
    final code = cubit.state.code;
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
          controller: controller..text = code.isNotEmpty ? code[index] : '',
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
    final cubit = context.read<SigninCubit>();

    return FittedBox(
      child: Row(
        children: List.generate(6, (index) => _pinDigitContainer(index, cubit)),
      ),
    );
  }
}
