import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/ui/shared/shared.dart';

class Initialize extends StatelessWidget {
  const Initialize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<SigninCubit>();
    cubit.initializeApp();

    return Center(
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            Text(
              'Initializing',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const Spacer(),
            const LoadingSpinner(),
          ],
        ),
      ),
    );
  }
}
