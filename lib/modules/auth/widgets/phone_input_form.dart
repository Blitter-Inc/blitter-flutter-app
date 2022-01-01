import 'package:flutter/material.dart';

import '../../../constants/animation.dart';
import '../../../widgets/translucent_text_form_field_container.dart';
import '../../../widgets/gradient_button.dart';

class PhoneInputForm extends StatefulWidget {
  final VoidCallback onSubmit;
  const PhoneInputForm({
    Key? key,
    required this.onSubmit,
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

  void animateOut() {
    _fieldController.reverse();
    _buttonController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SlideTransition(
            position: _fieldOffset,
            child: TranslucentTextFormFieldContainer(
              child: TextFormField(
                controller: _phoneNumberController,
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
              onPressed: () {
                animateOut();
                widget.onSubmit();
              },
            ),
          ),
        ],
      ),
    );
  }
}
