import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final ValueGetter getImage;
  final AsyncCallback pickImage;

  const Avatar({
    Key? key,
    required this.pickImage,
    required this.getImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = getImage();

    return InkWell(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 90,
            foregroundColor: Colors.black.withOpacity(0.9),
            backgroundColor: Colors.white.withOpacity(0.2),
            child: ClipOval(
                child: avatar != null
                    ? Image(
                        image: avatar,
                        width: 180,
                        height: 180,
                        fit: BoxFit.fill,
                      )
                    : const Icon(
                        Icons.person,
                        size: 135,
                      )),
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
      onTap: () => pickImage(),
    );
  }
}
