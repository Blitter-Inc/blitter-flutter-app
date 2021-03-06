import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/config.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/ui/shared.dart';

class PhoneInputForm extends StatefulWidget {
  final AsyncCallback animateOutForm;

  const PhoneInputForm({
    Key? key,
    required this.animateOutForm,
  }) : super(key: key);

  @override
  _PhoneInputFormState createState() => _PhoneInputFormState();
}

class _PhoneInputFormState extends State<PhoneInputForm>
    with TickerProviderStateMixin {
  late AnimationController _fieldController;
  late AnimationController _buttonController;
  late Animation<Offset> _fieldOffset;
  late Animation<Offset> _buttonOffset;

  final _phoneNumberController = TextEditingController();
  double phoneFieldPaddingVertical = 0;

  @override
  void initState() {
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
    _fieldController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _animateOut() {
    _fieldController.reverse();
    _buttonController.reverse();
  }

  void _onSubmit(SigninCubit cubit, ScaffoldMessengerState scaffoldMessenger) {
    final phoneNumber = _phoneNumberController.text;
    if (phoneNumber.length != 10 || phoneNumber[0] == '0') {
      scaffoldMessenger.hideCurrentSnackBar();
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Please provide valid phone number'),
        ),
      );
    } else {
      scaffoldMessenger.clearSnackBars();
      _animateOut();
      cubit.setPhoneNumber(_phoneNumberController.text);
      widget.animateOutForm();
      cubit.signin();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SigninCubit>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Column(
      children: [
        SlideTransition(
          position: _fieldOffset,
          child: TranslucentTextFormFieldContainer(
            paddingVertical: phoneFieldPaddingVertical,
            child: TextFormField(
              onFieldSubmitted: (_) => _onSubmit(cubit, scaffoldMessenger),
              controller: _phoneNumberController
                ..text = cubit.state.phoneNumber,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                counterText: '',
                label: Text('Enter Phone Number'),
                prefixText: '+91 ',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        SlideTransition(
          position: _buttonOffset,
          child: GradientButton(
            title: 'Continue >',
            onPressed: () => _onSubmit(cubit, scaffoldMessenger),
          ),
        ),
      ],
    );
  }
}
