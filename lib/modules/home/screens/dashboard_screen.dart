import 'package:flutter/material.dart';

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
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Press the following buttons to naviate to screens'),
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
