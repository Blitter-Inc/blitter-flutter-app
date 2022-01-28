import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/models.dart' show Bill;
import 'package:blitter_flutter_app/utils/extensions.dart';
import './bill_card_subscribers.dart';

class BillCard extends StatelessWidget {
  final Bill bill;
  final Function(BuildContext, {String billId}) showModalHandler;

  const BillCard({
    Key? key,
    required this.bill,
    required this.showModalHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactBloc = context.read<ContactBloc>();
    final colorScheme = Theme.of(context).colorScheme;
    final subtextStyle = TextStyle(
      color: colorScheme.cardSubtext,
      fontSize: 11.5,
    );
    final isFulfilled = bill.status == "fulfilled";

    return Container(
      height: 110,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: context.billCardBorderRadius,
            ),
            elevation: 5,
            shadowColor: Colors.grey.shade600,
            child: InkWell(
              borderRadius: context.billCardBorderRadius,
              onTap: () =>
                  showModalHandler(context, billId: bill.id.toString()),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '# ${bill.name}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: colorScheme.cardText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                ':${bill.type.toUpperCase()}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          isFulfilled
                              ? '₹ ${bill.amount}'
                              : '₹ ${bill.settledAmt} / ${bill.amount}',
                          style: TextStyle(
                            color: isFulfilled
                                ? Colors.green
                                : Colors.red.shade900,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isFulfilled) ...[
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                        ],
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          'By: ${contactBloc.getUserById(bill.createdBy)?.name}',
                          style: subtextStyle,
                        ),
                        const Spacer(),
                        Text(
                          'Updated: ${context.getBillLastUpdatedAt(bill.lastUpdatedAt)}',
                          style: subtextStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: BillCardSubscribers(bill: bill),
            top: 43,
            right: 15,
          ),
        ],
      ),
    );
  }
}

extension on BuildContext {
  BorderRadius get billCardBorderRadius => BorderRadius.circular(8);

  String getBillLastUpdatedAt(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final currentDateTime = DateTime.now();
    final midnight = DateTime(currentDateTime.year, currentDateTime.month,
        currentDateTime.day, 0, 0, 0);
    if (dateTime.isAfter(midnight)) {
      return DateFormat.Hm().format(dateTime);
    }
    return DateFormat('MMM d,').add_Hm().format(dateTime);
  }
}
