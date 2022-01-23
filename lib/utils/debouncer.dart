import 'dart:async';
import 'dart:ui';

class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer({required this.duration});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(duration, action);
  }
}
