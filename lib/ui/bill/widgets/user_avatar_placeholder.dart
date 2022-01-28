import 'package:flutter/material.dart';

class UserAvatarPlaceholder extends StatelessWidget {
  const UserAvatarPlaceholder({
    Key? key,
    required this.initialAlphabet,
    required this.size,
  }) : super(key: key);

  final String initialAlphabet;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CircleAvatar(
      backgroundColor: colorScheme.primary,
      child: Text(
        initialAlphabet,
        style: TextStyle(
          fontSize: size,
          color: Colors.black,
        ),
      ),
      radius: size,
    );
  }
}
