import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/cubits.dart';

class AmountInput extends StatelessWidget {
  const AmountInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<BillManagerCubit>();
    final state = cubit.state.billModalState!;

    return Column(
      children: [
        TextFormField(
          initialValue: state.amount,
          style: TextStyle(
            color: colorScheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            labelText: 'Amount',
            prefixText: '₹  ',
            prefixStyle: TextStyle(
              color: colorScheme.primary,
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
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Text('+100'),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                child: const Text('+500'),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                child: const Text('+1000'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
