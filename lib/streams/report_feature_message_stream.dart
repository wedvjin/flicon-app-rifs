import 'dart:async';

class ReportFeatureMessageStream {
  final StreamController<int> _controller = StreamController<int>.broadcast();
  Stream<int> get yourStream1 => _controller.stream;

  ReportFeatureMessageStream() {
    // Simulate emitting data to the stream at regular intervals (e.g., every second).
    int count = 0;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _controller.sink.add(count);
      count++;
      if (count >= 10) {
        // Close the stream after 10 values for this example.
        timer.cancel();
        _controller.close();
      }
    });
  }
}