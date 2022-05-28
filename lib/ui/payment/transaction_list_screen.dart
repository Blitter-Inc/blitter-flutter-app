import 'dart:convert';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/repositories.dart';
import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/ui/shared.dart';

class TransactionListScreen extends StatelessWidget {
  static const String route = '/transactions';

  const TransactionListScreen({Key? key}) : super(key: key);

  Future<List<Transaction>> _fetchTransactions(
    APIRepository apiRepository,
  ) async {
    var apiRes = await apiRepository.fetchTransactions();
    var apiResBody = jsonDecode(apiRes.body);

    final transactionMap = (apiResBody['object_map']! as Map<String, dynamic>)
        .cast<String, dynamic>();
    final transactionList = (apiResBody['ordered_sequence'] as List)
        .cast<int>()
        .map((transactionId) =>
            Transaction.fromAPIJson(transactionMap['$transactionId']))
        .toList();

    return transactionList;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);

    final apiRepository = context.read<APIRepository>();
    final contactBloc = context.read<ContactBloc>();
    final loggedInUserId = context.read<AuthBloc>().state.user!.id;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: colorScheme.primary,
        title: Row(
          children: const [
            Text(
              'Transactions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _fetchTransactions(apiRepository),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: LoadingSpinner(),
            );
          }

          final transactionList = snapshot.data!;

          return ListView.builder(
            itemBuilder: (context, index) {
              final transaction = transactionList[index];
              final isSender = transaction.sender == loggedInUserId;
              final contact = contactBloc.getUserById(
                  isSender ? transaction.receiver : transaction.sender)!;

              return Container(
                height: 80,
                width: mediaQuery.size.width,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${isSender ? 'To' : 'From'} ${contact.name}'),
                            // Text('Contact: ${contact.name}'),
                            const SizedBox(height: 5),
                            Text(
                              '${isSender ? 'Sent' : 'Received'} via ${transaction.mode.toUpperCase()}',
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '${isSender ? '-' : '+'} ₹${transaction.amount}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSender ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Colors.white38),
                  ],
                ),
              );
            },
            itemCount: transactionList.length,
          );
        },
      ),
    );
  }
}
