import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/config/animation.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/widgets/widgets.dart';
import './otp_input_field.dart';

class OTPInputForm extends StatefulWidget {
  final AsyncCallback animateOutForm;

  const OTPInputForm({
    Key? key,
    required this.animateOutForm,
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

  void _animateOut() {
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
              if (otp.length == 6) {
                _animateOut();
                final cubit = context.read<SigninCubit>();
                cubit.setCode(otp);
                widget.animateOutForm();
                cubit.verifyOTP();
              }
            },
          ),
        ),
      ],
    );
  }
}
