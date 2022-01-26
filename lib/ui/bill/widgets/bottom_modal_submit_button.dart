import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomModalSubmitButton extends StatelessWidget {
  const BottomModalSubmitButton({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final AsyncCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          // Navigator.of(context).pop();
          await onSubmit();
        },
        child: const Text('Save'),
      ),
    );
  }
}
