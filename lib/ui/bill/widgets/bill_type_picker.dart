import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:blitter_flutter_app/data/constants.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import 'package:blitter_flutter_app/utils/debouncer.dart';

class BillTypePicker extends StatelessWidget {
  BillTypePicker({
    Key? key,
    required this.onChanged,
    this.initialValue = '',
  }) : super(key: key);

  final String initialValue;
  final ValueSetter<String> onChanged;

  final _debouncer = Debouncer(duration: const Duration(milliseconds: 350));

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final _controller = FixedExtentScrollController(
      initialItem: BillType.valueIndexMap[initialValue]!,
    );

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
                scrollController: _controller,
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      BillType.displayValues[index],
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
                  _debouncer.run(() => onChanged(BillType.values[index]));
                },
                childCount: BillType.values.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
