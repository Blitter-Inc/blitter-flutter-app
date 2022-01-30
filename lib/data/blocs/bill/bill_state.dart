import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/data/types.dart';
import 'package:blitter_flutter_app/utils/date_time.dart';

class BillState {
  int totalCount;
  int inStateCount;
  String? ordering;
  List<int>? orderedSequence;
  Map<String, Bill>? objectMap;
  String? lastRefreshed;
  String? lastModified;

  BillState({
    this.totalCount = 0,
    this.inStateCount = 0,
    this.ordering,
    this.orderedSequence,
    this.objectMap,
    this.lastRefreshed,
    this.lastModified,
  });

  Map<String, Bill> generateObjectMapFromAPIJson(JsonMap objectMapJson) {
    return objectMapJson.map(
      (key, value) => MapEntry(key, Bill.fromAPIJson(value)),
    );
  }

  BillState.fromInitialCallJson(JsonMap json)
      : totalCount = json['total_count']!,
        inStateCount = json['object_map']!.length,
        ordering = json['ordering']!,
        orderedSequence = json['ordered_sequence']!.cast<int>(),
        lastRefreshed = getCurrentDateTimeString(),
        lastModified = getCurrentDateTimeString() {
    objectMap = generateObjectMapFromAPIJson(json['object_map']!);
  }

  BillState.fromJson(Map<String, dynamic> json)
      : totalCount = json['totalCount']!,
        inStateCount = json['inStateCount']!,
        ordering = json['ordering']!,
        orderedSequence = json['orderedSequence']!,
        objectMap = (json['objectMap']! as Map).map(
          (key, value) => MapEntry<String, Bill>(key, Bill.fromJson(value)),
        ),
        lastRefreshed = json['lastRefreshed']!,
        lastModified = json['lastModified']!;

  Map<String, dynamic> toJson(BillState state) => {
        'totalCount': state.totalCount,
        'inStateCount': state.inStateCount,
        'ordering': state.ordering,
        'orderedSequence': state.orderedSequence,
        'objectMap': state.objectMap?.map(
              (key, value) => MapEntry<String, dynamic>(key, value.toJson()),
            ) ??
            {},
        'lastRefreshed': state.lastRefreshed,
        'lastModified': state.lastModified,
      };

  BillState copyWith({
    int? totalCount,
    int? inStateCount,
    String? ordering,
    List<int>? orderedSequence,
    Map<String, Bill>? objectMap,
    String? lastRefreshed,
    String? lastModified,
  }) =>
      BillState(
        totalCount: totalCount ?? this.totalCount,
        inStateCount: inStateCount ?? this.inStateCount,
        ordering: ordering ?? this.ordering,
        orderedSequence: orderedSequence ?? this.orderedSequence,
        objectMap: objectMap ?? this.objectMap,
        lastRefreshed: lastRefreshed ?? this.lastRefreshed,
        lastModified: lastModified ?? this.lastModified,
      );

  BillState copyWithRefreshCallJson(JsonMap json) {
    final newObjectMapKeys =
        (json['object_map']! as Map<String, dynamic>).keys.toSet();
    final oldObjectMapKeys = objectMap!.keys.toSet();

    final newInStateCount =
        inStateCount + newObjectMapKeys.difference(oldObjectMapKeys).length;

    final orderedSequence = this.orderedSequence!.toList()
      ..removeWhere((element) => newObjectMapKeys.contains(element.toString()));
    final newOrderedSequence = json['ordered_sequence']!.cast<int>()
      ..addAll(orderedSequence);
    final newObjectMap = objectMap!
      ..addAll(generateObjectMapFromAPIJson(json['object_map']!));

    return BillState(
      totalCount: json['total_count']!,
      inStateCount: newInStateCount,
      ordering: ordering,
      orderedSequence: newOrderedSequence,
      objectMap: newObjectMap,
      lastRefreshed: getCurrentDateTimeString(),
      lastModified: getCurrentDateTimeString(),
    );
  }

  Bill? getBillById(int id) => objectMap![id.toString()];
}
