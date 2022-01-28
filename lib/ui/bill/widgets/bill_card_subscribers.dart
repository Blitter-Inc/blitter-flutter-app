import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/models.dart';

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

    return SizedBox(
      width: 100,
      height: 30,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...bill.subscribers
              .sublist(0, min(bill.subscribers.length, 2))
              .asMap()
              .map(
                (i, subscriber) => MapEntry(
                  i,
                  Positioned(
                    right:
                        bill.subscribers.length > 1 ? (i * 20) + 10 : (i * 20),
                    child: CircleAvatar(
                      radius: 15,
                      child: ClipOval(
                        child: Image.network(
                          contactBloc.getUserById(subscriber.user)!.avatar!,
                          errorBuilder: (context, error, stackTrace) =>
                              CircleAvatar(
                            backgroundColor: colorScheme.primary,
                            child: Text(
                              contactBloc
                                  .getUserById(subscriber.user)!
                                  .name![0],
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                            ),
                            radius: 15,
                          ),
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .values
              .toList(),
          if (bill.subscribers.length > 1)
            Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 9,
                child: Text(
                  '+${(bill.subscribers.length - 2).toString()}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
