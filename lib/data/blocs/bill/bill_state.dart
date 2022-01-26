import 'package:blitter_flutter_app/data/models.dart';

class FetchAPIOrderingOptions {
  static const latestFirst = "-updated_at";
  static const oldestFirst = "updated_at";
}

class BillState {
  int totalCount;
  int inStateCount;
  String? lastRefreshed;
  String? lastModified;
  int? currentPage;
  bool? hasNext;
  String? ordering;
  List<int>? orderedSequence;
  Map<String, Bill>? objectMap;

  BillState({
    this.totalCount = 0,
    this.inStateCount = 0,
    this.lastRefreshed,
    this.lastModified,
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
  })  : lastRefreshed = DateTime.now().toString(),
        lastModified = DateTime.now().toString();

  BillState.fromCache({
    required this.totalCount,
    required this.inStateCount,
    required this.hasNext,
    required this.orderedSequence,
    required this.objectMap,
    required this.ordering,
    required this.currentPage,
    required this.lastRefreshed,
    required this.lastModified,
  });

  BillState copyWithNextPage({
    required int currentPage,
    required bool hasNext,
    required List<int> orderedSequence,
    required Map<String, Bill> objectMap,
  }) =>
      BillState(
        totalCount: totalCount,
        inStateCount: inStateCount + objectMap.length,
        lastRefreshed: DateTime.now().toString(),
        lastModified: DateTime.now().toString(),
        currentPage: currentPage,
        hasNext: hasNext,
        ordering: ordering,
        orderedSequence: (this.orderedSequence ?? [])..addAll(orderedSequence),
        objectMap: (this.objectMap ?? {})..addAll(objectMap),
      );

  BillState copyWith({
    int? totalCount,
    int? inStateCount,
    String? lastRefreshed,
    String? lastModified,
    int? currentPage,
    bool? hasNext,
    String? ordering,
    List<int>? orderedSequence,
    Map<String, Bill>? objectMap,
  }) =>
      BillState(
        totalCount: totalCount ?? this.totalCount,
        inStateCount: inStateCount ?? this.inStateCount,
        lastRefreshed: lastRefreshed ?? this.lastRefreshed,
        lastModified: lastModified ?? this.lastModified,
        currentPage: currentPage ?? this.currentPage,
        hasNext: hasNext ?? this.hasNext,
        ordering: ordering ?? this.ordering,
        orderedSequence: orderedSequence ?? this.orderedSequence,
        objectMap: objectMap ?? this.objectMap,
      );
}
