import 'package:flutter/material.dart';

class BottomModalSubmitButton extends StatelessWidget {
  const BottomModalSubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Save'),
      ),
    );
  }
}
