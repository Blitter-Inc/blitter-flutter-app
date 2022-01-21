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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bill Manager',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: context.showColorPickerSheet,
            icon: const Icon(Icons.color_lens),
          ),
          IconButton(
            icon: BlocBuilder<ConfigBloc, ConfigState>(
              buildWhen: (previous, current) =>
                  previous.darkModeEnabled != current.darkModeEnabled,
              builder: (_, state) => Icon(
                state.darkModeEnabled ? Icons.mode_night : Icons.wb_sunny,
              ),
            ),
            onPressed: () {
              // configBloc.add(SwitchThemeMode());
              context.switchThemeMode();
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
            // height: 60,
            // child: Center(
            //   child: Text('ActionBar goes here'),
            // ),
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
