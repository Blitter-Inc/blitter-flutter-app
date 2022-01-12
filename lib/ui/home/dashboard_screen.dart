import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';

class DashboardScreen extends StatelessWidget {
  static const route = '/dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userName = context.read<AuthBloc>().state.user?.name ?? 'NULL';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome $userName\n\nPress the following buttons to naviate to screens',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            OutlinedButton(
              child: const Text('Bill Manager Screen'),
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              child: const Text('Event Organiser Screen'),
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              child: const Text('Expense Tracker Screen'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
