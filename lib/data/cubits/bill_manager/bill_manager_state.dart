import 'package:blitter_flutter_app/data/constants.dart';
import 'package:flutter/material.dart';

class BillManagerState {
  final int lastBuildTimestamp;
  final bool filtersEnabled;
  final bool searchBarEnabled;
  final TextEditingController searchController;
  final Map<String, dynamic> filters;
  final List<int> filteredSequence;

  BillManagerState({
    required this.lastBuildTimestamp,
    required this.filtersEnabled,
    required this.searchBarEnabled,
    required this.searchController,
    required this.filters,
    required this.filteredSequence,
  });

  BillManagerState.init({TextEditingController? searchController})
      : lastBuildTimestamp = DateTime.now().microsecondsSinceEpoch,
        filtersEnabled = false,
        searchBarEnabled = false,
        searchController = searchController ?? TextEditingController(),
        filters = {
          'ordering': FetchAPIOrdering.lastUpdatedAtDesc,
          'search': '',
          'status': '',
          'type': <String>{},
        },
        filteredSequence = [];

  BillManagerState copyWith({
    int? lastBuildTimestamp,
    bool? filtersEnabled,
    bool? searchBarEnabled,
    TextEditingController? searchController,
    Map<String, dynamic>? filters,
    List<int>? filteredSequence,
  }) =>
      BillManagerState(
        lastBuildTimestamp: lastBuildTimestamp ?? this.lastBuildTimestamp,
        filtersEnabled: filtersEnabled ?? this.filtersEnabled,
        searchBarEnabled: searchBarEnabled ?? this.searchBarEnabled,
        searchController: searchController ?? this.searchController,
        filters: filters ?? this.filters,
        filteredSequence: filteredSequence ?? this.filteredSequence,
      );

  String get orderingFilter => filters['ordering'];
  String get searchFilter => filters['search'];
  String get statusFilter => filters['status'];
  Set<String> get typeFilter => filters['type'];
}
