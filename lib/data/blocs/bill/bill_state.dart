import 'package:blitter_flutter_app/data/models.dart';

class FetchAPIOrderingOptions {
  static const latestFirst = "-updated_at";
  static const oldestFirst = "updated_at";
}

class BillState {
  int totalCount;
  int inStateCount;
  String? lastRefreshed;
  int? currentPage;
  bool? hasNext;
  String? ordering;
  List<String>? orderedSequence;
  Map<String, Bill>? objectMap;

  BillState({
    this.totalCount = 0,
    this.inStateCount = 0,
    this.lastRefreshed,
    this.currentPage,
    this.hasNext,
    this.ordering,
    this.orderedSequence,
    this.objectMap,
  });

  BillState.fromFetchedData({
    required this.totalCount,
    required this.inStateCount,
    required this.hasNext,
    required this.orderedSequence,
    required this.objectMap,
    this.ordering = FetchAPIOrderingOptions.latestFirst,
    this.currentPage = 1,
    this.lastRefreshed,
  });

  BillState.fromCache({
    required this.totalCount,
    required this.inStateCount,
    required this.hasNext,
    required this.orderedSequence,
    required this.objectMap,
    required this.ordering,
    required this.currentPage,
    required this.lastRefreshed,
  });

  BillState copyWithNextPage({
    required int currentPage,
    required bool hasNext,
    required List<String> orderedSequence,
    required Map<String, Bill> objectMap,
  }) =>
      BillState(
        totalCount: totalCount,
        inStateCount: inStateCount + objectMap.length,
        lastRefreshed: DateTime.now().toString(),
        currentPage: currentPage,
        hasNext: hasNext,
        ordering: ordering,
        orderedSequence: (this.orderedSequence ?? [])..addAll(orderedSequence),
        objectMap: (this.objectMap ?? {})..addAll(objectMap),
      );
}
