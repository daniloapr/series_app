import 'dart:async';

class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer(this.duration);

  void run(Function() function) {
    _timer?.cancel();
    _timer = Timer(duration, function);
  }
}
