import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final ValueGetter getImage;
  final AsyncCallback pickImage;
  final String? name;

  const Avatar(
      {Key? key, required this.pickImage, required this.getImage, this.name})
      : super(key: key);

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
            child: avatar != null
                ? ClipOval(
                    child: Image(
                      image: avatar,
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => name != null
                          ? CircleAvatar(
                              backgroundColor: Colors.black54.withOpacity(0.7),
                              child: Text(name![0],
                                  style: const TextStyle(
                                    fontSize: 80,
                                  )),
                              radius: 90,
                            )
                          : const Icon(
                              Icons.person,
                              size: 135,
                            ),
                    ),
                  )
                : const Icon(
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
      onTap: () => pickImage(),
    );
  }
}
