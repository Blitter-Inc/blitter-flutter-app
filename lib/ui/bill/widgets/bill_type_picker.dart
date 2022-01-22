import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:blitter_flutter_app/extensions.dart';

class BillTypePicker extends StatelessWidget {
  static const billTypes = [
    '-----',
    'Entertainment',
    'Food',
    'Shopping',
    'Outing',
    'Miscelleneous',
  ];

  const BillTypePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Select a bill type',
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: CupertinoPicker.builder(
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      billTypes[index],
                      style: TextStyle(
                        color: colorScheme.cupertinoPickerItemText,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
                itemExtent: 30,
                onSelectedItemChanged: (index) {
                  HapticFeedback.vibrate();
                  SystemSound.play(SystemSoundType.alert);
                  SystemSound.play(SystemSoundType.click);
                },
                childCount: billTypes.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
