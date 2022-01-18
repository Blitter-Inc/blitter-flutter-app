import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 90,
            foregroundColor: Colors.black.withOpacity(0.9),
            backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(
              Icons.person,
              size: 135,
            ),
          ),
          const Positioned(
            child: CircleAvatar(
              radius: 18,
              child: Icon(
                Icons.edit,
                size: 18,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
            right: 8,
            bottom: 0,
          )
        ],
      ),
      onTap: () {},
    );
  }
}