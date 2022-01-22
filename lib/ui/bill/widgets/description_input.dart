import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/cubits.dart';

class DescriptionInput extends StatelessWidget {
  const DescriptionInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<BillManagerCubit>();
    final state = cubit.state.billModalState!;

    return TextFormField(
      initialValue: state.description,
      textCapitalization: TextCapitalization.sentences,
      maxLines: 3,
      style: TextStyle(
        color: colorScheme.primary,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.white54,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
