import 'package:flutter/material.dart';

import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/ui/shared.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';

class DebitTransactionRow extends StatelessWidget {
  const DebitTransactionRow({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot<DashboardCounters> snapshot;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final isLoading = !snapshot.hasData;
    final data = snapshot.data;

    return Row(
      children: [
        Card(
          color: colorScheme.dashboardCardBackground,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              topLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          elevation: 10,
          shadowColor: colorScheme.primary,
          child: Container(
            height: 150,
            width: 155,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: isLoading
                ? const LoadingSpinner()
                : Column(
                    children: [
                      Text(
                        '${data!.debitTransactionCount}',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Debit Transactions were performed',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: Card(
            color: colorScheme.dashboardCardBackground,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            elevation: 10,
            shadowColor: colorScheme.primary,
            child: Container(
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: isLoading
                  ? const LoadingSpinner()
                  : Column(
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          data!.debitTransactionAmount.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'of amount was paid off as expense',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
