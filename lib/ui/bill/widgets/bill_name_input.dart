import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/cubits.dart';

class BillNameInput extends StatelessWidget {
  const BillNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<BillManagerCubit>();
    final state = cubit.state.billModalState!;

    return TextFormField(
      initialValue: state.name,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        labelText: 'Enter bill name',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: colorScheme.primary,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
