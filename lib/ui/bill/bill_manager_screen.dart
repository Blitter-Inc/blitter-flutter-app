import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/config.dart';
import 'package:blitter_flutter_app/data/blocs.dart';
import './widgets/widgets.dart';

class BillManagerScreen extends StatelessWidget {
  const BillManagerScreen({Key? key}) : super(key: key);

  static const route = '/bill_manager';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.billPrimaryColor,
        title: const Text(
          'Bill Manager',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 60,
            child: Center(
              child: Text('ActionBar goes here'),
            ),
          ),
          Expanded(
            child: BlocBuilder<BillBloc, BillState>(
              buildWhen: (previous, current) {
                return previous.lastRefreshed != current.lastRefreshed;
              },
              builder: (context, state) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final bill = state
                        .objectMap![state.orderedSequence![index].toString()]!;
                    return BillCard(
                      key: ValueKey(index),
                      bill: bill,
                    );
                  },
                  itemCount: state.inStateCount,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
