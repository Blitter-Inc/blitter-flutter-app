import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/data/repositories.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import './widgets/widgets.dart';

class BillManagerScreen extends StatefulWidget {
  const BillManagerScreen({Key? key}) : super(key: key);

  static const route = '/bill_manager';

  @override
  State<BillManagerScreen> createState() => _BillManagerScreenState();
}

class _BillManagerScreenState extends State<BillManagerScreen> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  late BillManagerCubit cubit;

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
    cubit = context.read<BillManagerCubit>();

    return BlocBuilder<BillManagerCubit, BillManagerState>(
      buildWhen: (previous, current) =>
          previous.searchBarEnabled != current.searchBarEnabled,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (state.searchBarEnabled) {
              cubit.disableSearchFilter();
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            body: RefreshIndicator(
              notificationPredicate: (_) => !state.searchBarEnabled,
              key: _refreshIndicatorKey,
              onRefresh: cubit.refreshBillState,
              displacement: 10,
              edgeOffset: 60 + mediaQuery.viewPadding.top,
              child: CustomScrollView(
                slivers: [
                  BillManagerAppBar(
                    showFilterModalHandler: _showFilterModal,
                    showBillModalHandler: _showBillModal,
                    refreshIndicatorKey: _refreshIndicatorKey,
                  ),
                  BlocListener<BillBloc, BillState>(
                    listenWhen: (previous, current) =>
                        previous.lastModified != current.lastModified,
                    listener: (_, __) => cubit.refreshPage(),
                    child: PagedSliverList(
                      pagingController: cubit.state.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Bill>(
                        noItemsFoundIndicatorBuilder: (context) =>
                            const NoBillFound(),
                        noMoreItemsIndicatorBuilder: (_) => const EndOfList(),
                        itemBuilder: (context, bill, index) {
                          return BillCard(
                            key: ValueKey(bill.id),
                            bill: bill,
                            showModalHandler: _showBillModal,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
