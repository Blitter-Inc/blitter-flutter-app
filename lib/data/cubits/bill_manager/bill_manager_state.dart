import 'package:blitter_flutter_app/data/constants.dart';

class BillManagerState {
  final int lastBuildTimestamp;
  final bool filtersEnabled;
  final Map<String, dynamic> filters;

  BillManagerState({
    required this.lastBuildTimestamp,
    required this.filtersEnabled,
    required this.filters,
  });

  BillManagerState.init()
      : lastBuildTimestamp = DateTime.now().microsecondsSinceEpoch,
        filtersEnabled = false,
        filters = {
          'ordering': FetchAPIOrdering.lastUpdatedAtDesc,
          'status': '',
          'type': <String>{},
        };

  BillManagerState copyWith({
    int? lastBuildTimestamp,
    bool? filtersEnabled,
    Map<String, dynamic>? filters,
  }) =>
      BillManagerState(
        lastBuildTimestamp: lastBuildTimestamp ?? this.lastBuildTimestamp,
        filtersEnabled: filtersEnabled ?? this.filtersEnabled,
        filters: filters ?? this.filters,
      );

  String get orderingFilter => filters['ordering'];
  String get statusFilter => filters['status'];
  Set<String> get typeFilter => filters['type'];
}
