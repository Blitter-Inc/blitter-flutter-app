import 'package:blitter_flutter_app/data/constants.dart';

class BillManagerState {
  final bool filtersEnabled;
  final Map<String, dynamic> filters;

  BillManagerState({
    required this.filtersEnabled,
    required this.filters,
  });

  BillManagerState.init()
      : filtersEnabled = false,
        filters = {
          'ordering': FetchAPIOrdering.lastUpdatedAtDesc,
          'status': '',
          'type': <String>{},
        };

  BillManagerState copyWith({
    bool? filtersEnabled,
    Map<String, dynamic>? filters,
  }) =>
      BillManagerState(
        filtersEnabled: filtersEnabled ?? this.filtersEnabled,
        filters: filters ?? this.filters,
      );
}
