import 'package:flutter/material.dart';

class BillAction extends StatelessWidget {
  const BillAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: const Text('Add Files'),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: const Text('Add People'),
            ),
          ),
        ],
      ),
    );
  }
}