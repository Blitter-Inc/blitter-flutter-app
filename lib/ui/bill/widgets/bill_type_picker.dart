import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/cubits.dart';
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

  static int getBillTypeIndex(String? type) {
    switch (type) {
      case 'entertainment':
        return 1;
      case 'food':
        return 2;
      case 'shopping':
        return 3;
      case 'outing':
        return 4;
      case 'miscelleneous':
        return 5;
      default:
        return 0;
    }
  }

  const BillTypePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<BillManagerCubit>();
    final state = cubit.state.billModalState!;
    final _controller = FixedExtentScrollController(
      initialItem: getBillTypeIndex(state.type),
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
