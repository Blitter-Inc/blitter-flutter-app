import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/constants.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/data/repositories.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import './widgets/widgets.dart';

class BillManagerScreen extends StatelessWidget {
  BillManagerScreen({Key? key}) : super(key: key);

  static const route = '/bill_manager';
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

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
      barrierColor: Colors.black87,
      isScrollControlled: true,
    );
  }

  void _showFilterModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BillManagerCubit>(),
        child: Dialog(
          child: const BillFilterModal(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Theme.of(context).colorScheme.modalBackground,
        ),
      ),
      barrierColor: Colors.black87,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final cubit = context.read<BillManagerCubit>();

    return Scaffold(
      body: BlocBuilder<BillBloc, BillState>(
        buildWhen: (previous, current) {
          return previous.lastModified != current.lastModified;
        },
        builder: (context, blocState) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async => await cubit.refreshBillState(
              lastRefreshed: blocState.lastRefreshed!,
            ),
            displacement: 10,
            edgeOffset: 60 + mediaQuery.viewPadding.top,
            child: CustomScrollView(
              slivers: [
                BillManagerAppBar(
                  refreshIndicatorKey: _refreshIndicatorKey,
                  showFilterModalHandler: _showFilterModal,
                  showBillModalHandler: _showBillModal,
                ),
                BlocBuilder<BillManagerCubit, BillManagerState>(
                  buildWhen: (previous, current) =>
                      previous.lastBuildTimestamp != current.lastBuildTimestamp,
                  builder: (context, cubitState) {
                    List<int> sequence = blocState.orderedSequence!;
                    if (cubitState.filtersEnabled) {
                      sequence = sequence.where((element) {
                        final bill = blocState.objectMap![element.toString()]!;
                        if (cubitState.statusFilter != '' &&
                            cubitState.statusFilter != bill.status) {
                          return false;
                        } else if (cubitState.typeFilter.isNotEmpty &&
                            !cubitState.typeFilter.contains(bill.type)) {
                          return false;
                        } else {
                          return true;
                        }
                      }).toList();
                      if (cubitState.orderingFilter ==
                          FetchAPIOrdering.lastUpdatedAtAsc) {
                        sequence = sequence.reversed.toList();
                      }
                    }
                    return sequence.isNotEmpty
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final bill = blocState
                                    .objectMap![sequence[index].toString()]!;
                                return BillCard(
                                  key: ValueKey(bill.id),
                                  bill: bill,
                                  showModalHandler: _showBillModal,
                                );
                              },
                              childCount: sequence.length,
                            ),
                          )
                        : const NoBillFound();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BillManagerAppBar extends StatelessWidget {
  const BillManagerAppBar({
    Key? key,
    required this.refreshIndicatorKey,
    required this.showFilterModalHandler,
    required this.showBillModalHandler,
  }) : super(key: key);

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final Function(BuildContext) showFilterModalHandler;
  final Function(BuildContext) showBillModalHandler;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
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
      elevation: 1,
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
                onPressed: () => showFilterModalHandler(context),
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
                onPressed: () => showBillModalHandler(context),
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
          onPressed: () => refreshIndicatorKey.currentState!.show(),
          icon: const Icon(Icons.refresh),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
