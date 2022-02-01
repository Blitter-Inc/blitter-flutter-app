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
  late PagingController<int, Bill> _pagingController;
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
          child: BillFilterModal(
            refreshList: _refreshList,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Theme.of(context).colorScheme.modalBackground,
        ),
      ),
      barrierColor: Colors.black87,
    );
  }

  void _refreshList() {
    _pagingController.refresh();
  }

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0);
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        cubit.fetchPage(pageKey: pageKey, controller: _pagingController);
      } catch (error) {
        _pagingController.error = error;
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    cubit = context.read<BillManagerCubit>();

    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await cubit.refreshBillState(
            callback: () => _pagingController.refresh(),
          );
        },
        displacement: 10,
        edgeOffset: 60 + mediaQuery.viewPadding.top,
        child: CustomScrollView(
          slivers: [
            BillManagerAppBar(
              showFilterModalHandler: _showFilterModal,
              showBillModalHandler: _showBillModal,
              refreshIndicatorKey: _refreshIndicatorKey,
              refreshListHandler: _refreshList,
            ),
            PagedSliverList(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Bill>(
                noItemsFoundIndicatorBuilder: (context) => const NoBillFound(),
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
          ],
        ),
      ),
    );
  }
}
