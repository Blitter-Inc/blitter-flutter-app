import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import './user_avatar.dart';

class BillViewModalSubscribers extends StatelessWidget {
  const BillViewModalSubscribers({
    Key? key,
    required this.bill,
    required this.loggedInUserSubscriberIndex,
  }) : super(key: key);

  final Bill bill;
  final int loggedInUserSubscriberIndex;

  void _showSubscriberModal() {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    final contactBloc = context.read<ContactBloc>();
    final colorScheme = Theme.of(context).colorScheme;

    final participantCount = bill.subscribers.length - 1;
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
                final subscriber = bill.subscribers[
                    index >= loggedInUserSubscriberIndex ? index + 1 : index];
                final user = contactBloc.getUserById(subscriber.user)!;

                return Container(
                  decoration: BoxDecoration(
                    color: colorScheme.modalBackground,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: InkWell(
                    onTap: _showSubscriberModal,
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        UserAvatar(
                          radius: 20,
                          url: user.avatar!,
                          placeholderAlphabet: user.name![0],
                        ),
                        const Spacer(),
                        Text(
                          subscriber.fulfilled
                              ? '₹ ${subscriber.amountPaid}'
                              : '₹ ${double.parse(subscriber.amountPaid).ceil()} / ${subscriber.amount}',
                          style: TextStyle(
                            color: subscriber.fulfilled
                                ? Colors.green
                                : Colors.red.shade900,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 18),
                      ],
                    ),
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
