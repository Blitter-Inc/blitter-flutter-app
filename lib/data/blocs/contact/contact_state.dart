import 'package:blitter_flutter_app/data/models/models.dart';
import 'package:blitter_flutter_app/utils/date_time.dart';

class ContactState {
  int totalCount;
  String? lastRefreshed;
  Map<String, User>? objectMap;

  ContactState({
    this.totalCount = 0,
    this.lastRefreshed,
    this.objectMap,
  });

  ContactState.fromFetchedData({
    required this.objectMap,
  })  : lastRefreshed = getCurrentDateTimeString(),
        totalCount = objectMap!.length;

  ContactState.fromCache({
    required this.lastRefreshed,
    required this.objectMap,
    required this.totalCount,
  });
}
