import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:blitter_flutter_app/config.dart';
import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/constants.dart';
import 'package:blitter_flutter_app/data/models.dart';
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

  Future<void> _syncBillsToState({
    required Map<String, dynamic> objectMapJson,
  }) async {
    if (objectMapJson.isEmpty) return;
    billBloc.add(AppendFetchedBills(
      objectMapJson: objectMapJson,
    ));
    await billBloc.stream.firstWhere(
        (element) => element.objectMap!.containsKey(objectMapJson.keys.first));
  }

  Future<void> _fetchAndSyncRequiredBillsToBillState({
    required List<int> sequence,
  }) async {
    final objectMap = billBloc.state.objectMap!;
    final List<int> billsToBeFetched = [];

    for (final id in sequence) {
      if (!objectMap.containsKey(id.toString())) {
        billsToBeFetched.add(id);
      }
    }

    if (billsToBeFetched.isNotEmpty) {
      final response = await apiRepository.fetchRequestedBills({
        'ids': billsToBeFetched,
      });
      final Map<String, dynamic> objectMapJson = jsonDecode(response.body);
      await _syncBillsToState(objectMapJson: objectMapJson);
    }
  }

  Future<void> _fetchAndSyncFilteredBillsToState() async {
    final response = await apiRepository.fetchBills(
      requestType: FetchAPIRequestType.initial,
      ordering: state.orderingFilter,
      batchSize: objectBatchSize,
      params: state.filters,
    );
    final apiRes = jsonDecode(response.body);
    emit(
      state.copyWith(
        filteredSequence:
            (apiRes['ordered_sequence']! as List<dynamic>).cast<int>(),
      ),
    );
    await _syncBillsToState(objectMapJson: apiRes['object_map']!);
  }

  List<Bill> _generateBillListFromSequence({required List<int> sequence}) {
    return sequence.map((e) => billBloc.state.getBillById(e)!).toList();
  }

  List<int> _generateCurrentPageSequence({
    required int pageKey,
    required List<int> sequence,
  }) {
    return sequence.sublist(
        pageKey, min(pageKey + objectBatchSize, sequence.length));
  }

  Future<List<Bill>> _generateCurrentPageBillList({
    required int pageKey,
    required List<int> sequence,
  }) async {
    final currentPageBillIdSequence = _generateCurrentPageSequence(
      pageKey: pageKey,
      sequence: sequence,
    );
    await _fetchAndSyncRequiredBillsToBillState(
        sequence: currentPageBillIdSequence);
    return _generateBillListFromSequence(sequence: currentPageBillIdSequence);
  }

  void _appendPage({
    required List<Bill> sequence,
    required PagingController controller,
    required int pageKey,
  }) {
    final nextPageKey = pageKey + objectBatchSize;
    final isLastPage = sequence.length < objectBatchSize;
    if (isLastPage) {
      controller.appendLastPage(sequence);
    } else {
      controller.appendPage(sequence, nextPageKey);
    }
  }

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
    late List<int> sequence;
    if (state.filtersEnabled) {
      if (pageKey == 0) {
        await _fetchAndSyncFilteredBillsToState();
      }
      sequence = state.filteredSequence;
    } else {
      sequence = billBloc.state.orderedSequence!;
    }
    final currentPageBillList = await _generateCurrentPageBillList(
      pageKey: pageKey,
      sequence: sequence,
    );
    _appendPage(
      sequence: currentPageBillList,
      controller: controller,
      pageKey: pageKey,
    );
  }
}
