import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import './user_avatar.dart';

class BillCardSubscribers extends StatelessWidget {
  const BillCardSubscribers({
    Key? key,
    required this.bill,
  }) : super(key: key);

  final Bill bill;

  @override
  Widget build(BuildContext context) {
    final contactBloc = context.read<ContactBloc>();
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        ...bill.subscribers
            .sublist(0, min(bill.subscribers.length, 2))
            .asMap()
            .map(
              (i, subscriber) {
                final user = contactBloc.getUserById(subscriber.user)!;

                return MapEntry(
                  i,
                  Positioned(
                    right:
                        bill.subscribers.length > 1 ? (i * 25) + 7 : (i * 25),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: UserAvatar(
                        radius: 20,
                        url: user.avatar,
                        placeholderAlphabet: user.name![0],
                      ),
                    ),
                  ),
                );
              },
            )
            .values
            .toList(),
        if (bill.subscribers.length > 2)
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: CircleAvatar(
                radius: 9,
                child: Text(
                  '+${bill.subscribers.length - 2}',
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: colorScheme.cardText,
              ),
            ),
          ),
      ],
    );
  }
}
