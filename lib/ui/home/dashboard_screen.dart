import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import 'package:blitter_flutter_app/ui.dart';

class DashboardScreen extends StatelessWidget {
  static const route = '/dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) {
                return previous.user?.name != current.user?.name;
              },
              builder: (context, state) {
                return Text(
                  'Welcome ${state.user?.name}\n\nPress the following buttons to test implemented functionalities of the app',
                  textAlign: TextAlign.center,
                );
              },
            ),
            const SizedBox(height: 30),
            OutlinedButton(
              child: const Text('Bill Manager Screen'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  BillManagerScreen.route,
                );
              },
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              child: const Text('Toggle Theme Mode'),
              onPressed: context.switchThemeMode,
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              child: const Text('Open Color Picker'),
              onPressed: context.showColorPickerSheet,
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              child: const Text('Reset App'),
              onPressed: context.resetApp,
            ),
          ],
        ),
      ),
    );
  }
}
