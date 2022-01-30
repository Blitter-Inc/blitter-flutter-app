import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:blitter_flutter_app/config.dart';
import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/constants.dart';
import 'package:blitter_flutter_app/data/repositories.dart';
import './bill_manager_state.dart';

class BillManagerCubit extends Cubit<BillManagerState> {
  BillManagerCubit({
    required this.apiRepository,
    required this.apiSerializerRepository,
    required this.billBloc,
  }) : super(BillManagerState.init());

  final APIRepository apiRepository;
  final APISerializerRepository apiSerializerRepository;
  final BillBloc billBloc;

  void setOrderingFilter(String ordering) {
    emit(state.copyWith(
        filters: state.filters..update('ordering', (_) => ordering)));
  }

  void setStatusFilter(String status) {
    emit(state.copyWith(
        filters: state.filters..update('status', (_) => status)));
  }

  void clearStatusFilter() {
    emit(state.copyWith(filters: state.filters..update('status', (_) => '')));
  }

  void addTypeFilter(String type) {
    emit(state.copyWith(
        filters: state.filters..update('type', (value) => value..add(type))));
  }

  void removeTypeFilter(String type) {
    emit(state.copyWith(
        filters: state.filters
          ..update('type', (value) => value..remove(type))));
  }

  void enableFilters() {
    emit(state.copyWith(
      filtersEnabled: true,
      lastBuildTimestamp: DateTime.now().microsecondsSinceEpoch,
    ));
  }

  void clearFilters() {
    emit(BillManagerState.init());
  }

  Future<void> refreshBillState({Function? callback}) async {
    final response = await apiRepository.fetchBills(
      requestType: FetchAPIRequestType.refresh,
      ordering: FetchAPIOrdering.lastUpdatedAtDesc,
      lastRefreshed: billBloc.state.lastRefreshed,
    );
    final event = RefreshBillState(
      json: jsonDecode(response.body),
      callback: callback,
    );
    billBloc.add(event);
  }

  Future<void> fetchPage({
    required int pageKey,
    required PagingController controller,
  }) async {
    final nextPageKey = pageKey + objectBatchSize;

    final state = billBloc.state;
    final currentPageBillIds = state.orderedSequence!
        .sublist(pageKey, min(nextPageKey, state.totalCount));
    final List<int> billsToBeFetched = [];

    for (final id in currentPageBillIds) {
      if (!state.objectMap!.containsKey(id.toString())) {
        billsToBeFetched.add(id);
      }
    }

    if (billsToBeFetched.isNotEmpty) {
      final response =
          await apiRepository.fetchRequestedBills({'ids': billsToBeFetched});
      final Map<String, dynamic> objectMapJson = jsonDecode(response.body);
      billBloc.add(AppendFetchedBills(
        objectMapJson: objectMapJson,
      ));
      await billBloc.stream.firstWhere((element) =>
          element.objectMap!.containsKey(objectMapJson.keys.first));
    }

    final currentPageBills =
        currentPageBillIds.map((e) => state.getBillById(e)!).toList();
    final isLastPage = currentPageBillIds.length < objectBatchSize;

    if (isLastPage) {
      controller.appendLastPage(currentPageBills);
    } else {
      controller.appendPage(currentPageBills, nextPageKey);
    }
  }
}
