import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomModalButton extends StatefulWidget {
  const BottomModalButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.validate,
  }) : super(key: key);

  final String label;
  final AsyncCallback onPressed;
  final Future<bool> Function() validate;

  @override
  State<BottomModalButton> createState() => _BottomModalButtonState();
}

class _BottomModalButtonState extends State<BottomModalButton> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_enabled) {
            setState(() {
              _enabled = false;
            });
            final isValid = await widget.validate();
            if (isValid) {
              widget.onPressed();
            } else {
              setState(() {
                _enabled = true;
              });
            }
          }
        },
        child: _enabled
            ? Text(widget.label)
            : const SizedBox.square(
                dimension: 15,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
      ),
    );
  }
}
