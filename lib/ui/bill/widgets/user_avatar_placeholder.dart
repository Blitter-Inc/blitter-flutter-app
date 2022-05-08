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
    return CircleAvatar(
      backgroundColor: Colors.transparent,
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
