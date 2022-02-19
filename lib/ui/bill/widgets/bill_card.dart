import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:intl/intl.dart' as intl;

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

  double _getTextWidth({
    required MediaQueryData mediaQuery,
    required TextStyle style,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: '# ${bill.name}',
        style: style,
      ),
      textScaleFactor: mediaQuery.textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout();
    return painter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    final contactBloc = context.read<ContactBloc>();
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final subtextStyle = TextStyle(
      color: colorScheme.cardSubtext,
      fontSize: 11.5,
    );
    final isFulfilled = bill.status == "fulfilled";

    final billNameStyle = TextStyle(
      color: colorScheme.cardText,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    final billNameWidth = _getTextWidth(
      mediaQuery: mediaQuery,
      style: billNameStyle,
    );

    final cardWidth = mediaQuery.size.width - 44;

    return Container(
      height: 110,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: context.billCardBorderRadius,
        ),
        elevation: 5,
        shadowColor: Colors.grey.shade600,
        child: InkWell(
          borderRadius: context.billCardBorderRadius,
          onTap: () => showModalHandler(context, billId: bill.id.toString()),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: cardWidth / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (billNameWidth > (cardWidth / 2))
                                SizedBox(
                                  height: 20,
                                  child: Marquee(
                                    text: '# ${bill.name}',
                                    style: billNameStyle,
                                    blankSpace: 30,
                                    velocity: 40,
                                  ),
                                )
                              else
                                Text(
                                  '# ${bill.name}',
                                  style: billNameStyle,
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
                BillCardSubscribers(bill: bill),
              ],
            ),
          ),
        ),
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
      return intl.DateFormat.Hm().format(dateTime);
    }
    return intl.DateFormat('MMM d,').add_Hm().format(dateTime);
  }
}
