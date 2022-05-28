import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import './user_avatar_placeholder.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.radius,
    required this.url,
    required this.placeholderAlphabet,
  }) : super(key: key);

  final double radius;
  final String? url;
  final String placeholderAlphabet;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.primary,
      child: ClipOval(
        child: CachedNetworkImage(
          fadeOutDuration: const Duration(milliseconds: 250),
          imageUrl: url ?? '',
          fit: BoxFit.cover,
          // height: 36,
          // width: 36,
          placeholder: (context, url) => UserAvatarPlaceholder(
            initialAlphabet: placeholderAlphabet,
            size: 15,
          ),
          errorWidget: (context, url, error) => UserAvatarPlaceholder(
            initialAlphabet: placeholderAlphabet,
            size: 15,
          ),
        ),
      ),
    );
  }
}
