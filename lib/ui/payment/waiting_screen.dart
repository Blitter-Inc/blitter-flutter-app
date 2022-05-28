import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/ui.dart';

class WaitingScreen extends StatelessWidget {
  static const route = '/wait';
  const WaitingScreen({Key? key}) : super(key: key);

  void _notifyBackend(
      BuildContext context, BillModalCubit billModalCubit) async {
    final authBloc = context.read<AuthBloc>();

    if (billModalCubit.state.bill == null) {
      return;
    }
    final bill = billModalCubit.state.bill!;
    final subscriber = billModalCubit.state.inTransactionBillSubscriber!;
    await billModalCubit.createTransaction({
      'sender': authBloc.state.user!.id,
      'receiver': bill.createdBy,
      'mode': billModalCubit.state.inProcessingTransactionMode,
      'amount':
          double.parse(subscriber.amount) - double.parse(subscriber.amountPaid),
      'status': 'success',
      'subscriber_id': subscriber.id,
    });

    await billModalCubit.refreshBill(id: bill.id);
    billModalCubit.resetState();
    Navigator.of(context)
        .popUntil((route) => route.settings.name == BillManagerScreen.route);
  }

  @override
  Widget build(BuildContext context) {
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
