import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './otp_input_field.dart';
import '../../../constants/animation.dart';
import '../../../widgets/gradient_button.dart';

class OTPInputForm extends StatefulWidget {
  final AsyncCallback onSubmit;

  const OTPInputForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _OTPInputFormState createState() => _OTPInputFormState();
}

class _OTPInputFormState extends State<OTPInputForm>
    with TickerProviderStateMixin {
  late AnimationController _fieldController;
  late AnimationController _buttonController;
  late Animation<Offset> _fieldOffset;
  late Animation<Offset> _buttonOffset;

  late List<FocusNode> pinFocusNodes;
  late List<TextEditingController> pinEditingControllers;

  @override
  void initState() {
    pinFocusNodes = List.generate(6, (_) => FocusNode());
    pinEditingControllers = List.generate(6, (_) => TextEditingController());

    _fieldController = AnimationController(
      vsync: this,
      duration: defaultTransitionDuration,
    );
    _buttonController = AnimationController(
      vsync: this,
      duration: defaultTransitionDuration,
    );
    _fieldOffset =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _fieldController,
        curve: Curves.easeInOut,
      ),
    );
    _buttonOffset =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeInOut,
      ),
    );

    _fieldController.forward();
    _buttonController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _fieldController.reverse();
    _buttonController.reverse();

    super.dispose();
  }

  void animateOut() {
    _fieldController.reverse();
    _buttonController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideTransition(
          position: _fieldOffset,
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 300),
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Enter the OTP sent to your mobile',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              OTPInputField(
                pinFocusNodes: pinFocusNodes,
                pinEditingControllers: pinEditingControllers,
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        SlideTransition(
          position: _buttonOffset,
          child: GradientButton(
            title: 'Verify',
            onPressed: () {
              String otp = pinEditingControllers.map((e) => e.text).join();
              print(otp);
              animateOut();
              widget.onSubmit();
            },
          ),
        ),
      ],
    );
  }
}
