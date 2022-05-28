import 'package:blitter_flutter_app/ui/shared/translucent_text_form_field_container.dart';
import 'package:flutter/material.dart';

class NewVpaScreen extends StatefulWidget {
  static const route = '/new_vpa';

  const NewVpaScreen({Key? key}) : super(key: key);

  @override
  State<NewVpaScreen> createState() => _NewVpaScreenState();
}

class _NewVpaScreenState extends State<NewVpaScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: colorScheme.primary,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Add VPA for UPI payments',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'VPA: Virtual Private Address, specifies the UPI linked bank account.',
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'This will be a one time ask, after which the entered VPA will be stored in our database. You can add, edit or delete VPAs at later point of time',
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
              child: TranslucentTextFormFieldContainer(
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text('VPA'),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
