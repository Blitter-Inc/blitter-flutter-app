import 'dart:math';

import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import './user_avatar.dart';

class BillEditModalSubscribers extends StatelessWidget {
  const BillEditModalSubscribers({
    Key? key,
    required this.billModalInput,
    // required this.loggedInUserSubscriberIndex,
  }) : super(key: key);

  final BillModalInput billModalInput;
  // final int loggedInUserSubscriberIndex;

  @override
  Widget build(BuildContext context) {
    final contactBloc = context.read<ContactBloc>();
    final colorScheme = Theme.of(context).colorScheme;

    final participantCount = billModalInput.subscribers.length;
    final double subscriberListHeight = min(
      50 +
          (55 * (participantCount / 2).ceil()) +
          (10 * ((participantCount / 2).ceil() - 1)),
      180,
    );

    return Container(
      height: subscriberListHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: colorScheme.modalBackgroundSecondary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(left: 5),
              width: double.infinity,
              child: Text(
                "Participants",
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 15.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final subscriber = billModalInput.subscribers[index];
                final user = contactBloc.getUserById(subscriber.user)!;

                return Container(
                  decoration: BoxDecoration(
                    color: colorScheme.modalBackground,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      UserAvatar(
                        radius: 20,
                        url: user.avatar,
                        placeholderAlphabet: user.name![0],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          readOnly: true,
                          textAlign: TextAlign.right,
                          initialValue: subscriber.amount,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}')),
                          ],
                          onChanged: (value) => subscriber.setAmount(value),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Colors.red.shade900,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                    ],
                  ),
                );
              },
              childCount: participantCount,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 55,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
        ],
      ),
    );
  }
}
