import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }) : super(BillManagerState.init()) {
    state.pagingController.addPageRequestListener((pageKey) async {
      try {
        fetchPage(pageKey: pageKey);
      } catch (error) {
        state.pagingController.error = error;
      }
    });
  }

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
    required int pageKey,
  }) {
    final nextPageKey = pageKey + objectBatchSize;
    final isLastPage = sequence.length < objectBatchSize;
    if (isLastPage) {
      state.pagingController.appendLastPage(sequence);
    } else {
      state.pagingController.appendPage(sequence, nextPageKey);
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
    final initialState = BillManagerState.init(
      searchController: state.searchController,
      pagingController: state.pagingController,
    );
    if (state.searchBarEnabled) {
      // Clear filters for search results
      emit(initialState.copyWith(
        filtersEnabled: true,
        searchBarEnabled: true,
        filters: initialState.filters
          ..update('search', (_) => state.searchFilter),
      ));
    } else {
      // Clear all filters
      emit(initialState);
    }
  }

  void enableSearchBar() {
    emit(state.copyWith(
      searchBarEnabled: !state.searchBarEnabled,
    ));
  }

  void enableSearchFilter() {
    emit(state.copyWith(
      filtersEnabled: true,
      filters: state.filters
        ..update('search', (_) => state.searchController.text),
    ));
    refreshPage();
  }

  void disableSearchFilter() {
    emit(BillManagerState.init(
      searchController: state.searchController..clear(),
      pagingController: state.pagingController,
    ));
    refreshPage();
  }

  void refreshPage() {
    state.pagingController.refresh();
  }

  Future<void> refreshBillState() async {
    final response = await apiRepository.fetchBills(
      requestType: FetchAPIRequestType.refresh,
      ordering: FetchAPIOrdering.lastUpdatedAtDesc,
      lastRefreshed: billBloc.state.lastRefreshed,
    );
    final event = RefreshBillState(
      json: jsonDecode(response.body),
      callback: refreshPage,
    );
    billBloc.add(event);
  }

  Future<void> fetchPage({
    required int pageKey,
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
      pageKey: pageKey,
    );
  }

  @override
  Future<void> close() {
    state.searchController.dispose();
    state.pagingController.dispose();
    return super.close();
  }
}
