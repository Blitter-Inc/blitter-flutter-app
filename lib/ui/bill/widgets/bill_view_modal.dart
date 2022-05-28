import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/ui/payment/payment.dart';
import './bill_edit_toggle.dart';
import './bill_type_badge.dart';
import './bill_view_modal_subscribers.dart';
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
    final authBloc = context.read<AuthBloc>();
    final contactBloc = context.read<ContactBloc>();
    final billModalCubit = context.read<BillModalCubit>();

    final editToggleEnabled = hasEditPermission(
      context: context,
      createdBy: bill.createdBy,
    );
    final loggedInUserSubscriberIndex = bill.subscribers.indexWhere(
      (element) => element.user == authBloc.state.user!.id,
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
                          fontSize: 20,
                          color: colorScheme.primary,
                        ),
                        children: [
                          const TextSpan(text: 'Amount: '),
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
                if (bill.subscribers.isNotEmpty) ...[
                  const SizedBox(height: 25),
                  BillViewModalSubscribers(
                    bill: bill,
                  ),
                ],
                if (loggedInUserSubscriberIndex != -1) ...[
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (bill.subscribers[loggedInUserSubscriberIndex]
                            .fulfilled) {
                          return;
                        }
                        final receiver =
                            contactBloc.getUserById(bill.createdBy)!;
                        billModalCubit.inTransactionBillSubscriber =
                            bill.subscribers[loggedInUserSubscriberIndex];
                        Navigator.pushNamed(
                          context,
                          PaymentScreen.route,
                          arguments: PaymentScreenArguments(
                            bill: bill,
                            amount: double.parse(bill
                                    .subscribers[loggedInUserSubscriberIndex]
                                    .amount) -
                                double.parse(bill
                                    .subscribers[loggedInUserSubscriberIndex]
                                    .amountPaid),
                            receiverName: receiver.name!,
                            receiverPaymentAddress: receiver.upi!,
                            billModalCubit: billModalCubit,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: Text(bill.subscribers[loggedInUserSubscriberIndex]
                              .fulfilled
                          ? 'Your settlement for this bill is complete'
                          : 'Tap to settle your remaining ₹${double.parse(bill.subscribers[loggedInUserSubscriberIndex].amount) - double.parse(bill.subscribers[loggedInUserSubscriberIndex].amountPaid)}'),
                    ),
                  ),
                ],
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
