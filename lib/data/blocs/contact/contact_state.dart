import 'package:blitter_flutter_app/data/models/models.dart';

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
  })  : lastRefreshed = DateTime.now().toString(),
        totalCount = objectMap!.length;

  ContactState.fromCache({
    required this.lastRefreshed,
    required this.objectMap,
    required this.totalCount,
  });
}
