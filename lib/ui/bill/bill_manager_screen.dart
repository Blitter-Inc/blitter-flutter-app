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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocBuilder<BillBloc, BillState>(
        buildWhen: (previous, current) {
          return previous.lastModified != current.lastModified;
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                floating: true,
                pinned: true,
                snap: true,
                stretch: true,
                elevation: 4,
                bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, 60),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_alt, size: 16),
                          label: const Text('Filter'),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            side: BorderSide(
                              color: colorScheme.primary,
                              width: 1.2,
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () => _showBillModal(context),
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('Add Bill'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                        state.darkModeEnabled
                            ? Icons.mode_night
                            : Icons.wb_sunny,
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
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final bill = state
                      .objectMap![state.orderedSequence![index].toString()]!;
                  return BillCard(
                    key: ValueKey(bill.id),
                    bill: bill,
                    showModalHandler: _showBillModal,
                  );
                }, childCount: state.inStateCount),
              ),
            ],
          );
        },
      ),
    );
  }
}
