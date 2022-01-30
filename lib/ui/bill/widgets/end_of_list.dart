import 'package:flutter/material.dart';

class EndOfList extends StatelessWidget {
  const EndOfList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8, bottom: 12),
      child: Center(
        child: Text(
          'End of list',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
