import 'package:blitter_flutter_app/data/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/cubits.dart';

class WaitingScreen extends StatelessWidget {
  static const route = '/wait';
  const WaitingScreen({Key? key}) : super(key: key);

  void _notifyBackend(BuildContext context, BillModalCubit billModalCubit) async {
    final authBloc = context.read<AuthBloc>();

    final bill = billModalCubit.state.bill!;
    final subscriber = billModalCubit.state.inTransactionBillSubscriber!;

    await billModalCubit.createTransaction({
      'sender': authBloc.state.user!.id,
      'receiver': bill.createdBy,
      'mode': 'upi',
      'amount':
          double.parse(subscriber.amount) - double.parse(subscriber.amountPaid),
      'status': 'success',
      'subscriber_id': subscriber.id,
    });
    await billModalCubit.refreshBill(id: bill.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // final bill = ModalRoute.of(context)!.settings.arguments as Bill;
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final bill = args['bill'] as Bill;
    // final billSubscriber = args['']
    final billModalCubit =
        ModalRoute.of(context)!.settings.arguments as BillModalCubit;

    _notifyBackend(context, billModalCubit);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 150,
          child: Column(
            children: [
              Text(
                'Please Wait',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              CircularProgressIndicator(
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
