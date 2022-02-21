import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:blitter_flutter_app/data/constants.dart';
import 'package:blitter_flutter_app/data/models.dart';

class BillManagerState {
  final int lastBuildTimestamp;
  final bool filtersEnabled;
  final bool searchBarEnabled;
  final TextEditingController searchController;
  final PagingController<int, Bill> pagingController;
  final Map<String, dynamic> filters;
  final List<int> filteredSequence;

  BillManagerState({
    required this.lastBuildTimestamp,
    required this.filtersEnabled,
    required this.searchBarEnabled,
    required this.searchController,
    required this.pagingController,
    required this.filters,
    required this.filteredSequence,
  });

  static Map<String, dynamic> get defaultFilters => {
        'ordering': FetchAPIOrdering.lastUpdatedAtDesc,
        'search': '',
        'status': '',
        'type': <String>{},
      };

  BillManagerState.init({
    TextEditingController? searchController,
    PagingController<int, Bill>? pagingController,
  })  : lastBuildTimestamp = DateTime.now().microsecondsSinceEpoch,
        filtersEnabled = false,
        searchBarEnabled = false,
        searchController = searchController ?? TextEditingController(),
        pagingController =
            pagingController ?? PagingController(firstPageKey: 0),
        filters = defaultFilters,
        filteredSequence = [];

  BillManagerState copyWith({
    int? lastBuildTimestamp,
    bool? filtersEnabled,
    bool? searchBarEnabled,
    TextEditingController? searchController,
    PagingController<int, Bill>? pagingController,
    Map<String, dynamic>? filters,
    List<int>? filteredSequence,
  }) =>
      BillManagerState(
        lastBuildTimestamp: lastBuildTimestamp ?? this.lastBuildTimestamp,
        filtersEnabled: filtersEnabled ?? this.filtersEnabled,
        searchBarEnabled: searchBarEnabled ?? this.searchBarEnabled,
        searchController: searchController ?? this.searchController,
        pagingController: pagingController ?? this.pagingController,
        filters: filters ?? this.filters,
        filteredSequence: filteredSequence ?? this.filteredSequence,
      );

  String get orderingFilter => filters['ordering'];
  String get searchFilter => filters['search'];
  String get statusFilter => filters['status'];
  Set<String> get typeFilter => filters['type'];
}
