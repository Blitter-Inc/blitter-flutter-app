import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/data/repositories.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import './widgets/widgets.dart';

class BillManagerScreen extends StatelessWidget {
  const BillManagerScreen({Key? key}) : super(key: key);

  static const route = '/bill_manager';

  void _showBillModal(BuildContext context, {String? billId}) {
    showModalBottomSheet(
      context: context,
      builder: (_) => BlocProvider(
        create: (_) => BillModalCubit(
          billBloc: context.read<BillBloc>(),
          apiRepository: context.read<APIRepository>(),
        ),
        child: BillModal(billId: billId),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      barrierColor: Colors.black87,
      isScrollControlled: true,
    );
  }

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
                return previous.lastModified != current.lastModified;
              },
              builder: (context, state) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final bill = state
                        .objectMap![state.orderedSequence![index].toString()]!;
                    return BillCard(
                      key: ValueKey(bill.id),
                      bill: bill,
                      showModalHandler: _showBillModal,
                    );
                  },
                  itemCount: state.inStateCount,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBillModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
