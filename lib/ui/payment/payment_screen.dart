import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './payment_screen_arguments.dart';
import './waiting_screen.dart';

class PaymentScreen extends StatelessWidget {
  static const route = '/payment';

  const PaymentScreen({Key? key}) : super(key: key);

  Future<void> _initUpiTransaction(
    BuildContext context,
    PaymentScreenArguments args,
  ) async {
    args.billModalCubit.inProcessingTransactionmode = 'upi';
    const platform = MethodChannel("upi");
    try {
      dynamic res = await platform.invokeMethod("pay", {
        'name': args.receiverName,
        'vpa': args.receiverPaymentAddress,
        'amount': '${args.amount}',
        'currency': 'INR',
      });
      debugPrint("TEST RESPONSE: $res");
      Navigator.of(context).popAndPushNamed(
        WaitingScreen.route,
        arguments: args.billModalCubit,
      );
    } on PlatformException catch (e) {
      debugPrint("Flutter UPI Exception: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Rxception occured."),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _markAsSettled(
    BuildContext context,
    PaymentScreenArguments args,
  ) async {
    args.billModalCubit.inProcessingTransactionmode = 'cash';
    Navigator.of(context).popAndPushNamed(
      WaitingScreen.route,
      arguments: args.billModalCubit,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final args =
        ModalRoute.of(context)!.settings.arguments as PaymentScreenArguments;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: colorScheme.primary,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 130,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  '₹${args.amount}',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 78,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Will be sent to ${args.receiverName} (${args.receiverPaymentAddress})',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 8),
            width: double.infinity,
            child: Text(
              'Select payment method',
              style: TextStyle(
                color: colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _initUpiTransaction(context, args),
              child: const Text('UPI'),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _markAsSettled(context, args),
              child: const Text('Mark as Settled'),
            ),
          ),
        ],
      ),
    );
  }
}
