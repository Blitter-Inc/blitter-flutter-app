import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:blitter_flutter_app/data/models.dart';
import './bill_edit_toggle.dart';
import './bill_type_badge.dart';
import './progress_bar.dart';

class BillViewModal extends StatelessWidget {
  const BillViewModal({
    Key? key,
    required this.bill,
    required this.toggleEdit,
    required this.hasEditPermission,
  }) : super(key: key);

  final Bill bill;
  final AsyncCallback toggleEdit;
  final bool Function({
    required BuildContext context,
    required int createdBy,
  }) hasEditPermission;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editToggleEnabled = hasEditPermission(
      context: context,
      createdBy: bill.createdBy,
    );

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: editToggleEnabled ? 50 : 10),
          padding: const EdgeInsets.only(top: 7),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 20,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  width: double.infinity,
                  child: Text(
                    bill.name,
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (bill.description.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    width: double.infinity,
                    height: 19,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        bill.description,
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                ProgressBar(
                  currentValue: double.parse(bill.settledAmt),
                  totalValue: double.parse(bill.amount),
                ),
                const SizedBox(height: 10),
                const Divider(),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: Text.rich(
                    TextSpan(
                        style: TextStyle(
                          fontSize: 15.5,
                          color: colorScheme.primary,
                        ),
                        children: [
                          const TextSpan(text: 'Settlement: '),
                          TextSpan(
                            text: ' ₹${bill.settledAmt}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' of '),
                          TextSpan(
                            text: '₹${bill.amount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
        BillTypeBadge(type: bill.type),
        if (editToggleEnabled) BillEditToggle(onTap: toggleEdit),
      ],
    );
  }
}
