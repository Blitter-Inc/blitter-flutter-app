import 'package:flutter/material.dart';

class BillAction extends StatelessWidget {
  const BillAction({
    Key? key,
    required this.addPeopleModalHandler,
    required this.equateAmountModalHandler,
  }) : super(key: key);

  final VoidCallback addPeopleModalHandler;
  final VoidCallback equateAmountModalHandler;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextButton(
              onPressed: equateAmountModalHandler,
              child: const Text('Equate Amount'),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: addPeopleModalHandler,
              child: const Text('Add People'),
            ),
          ),
        ],
      ),
    );
  }
}
