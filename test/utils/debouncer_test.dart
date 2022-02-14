import 'package:flutter_test/flutter_test.dart';
import 'package:series_app/utils/debouncer.dart';

void main() {
  group('Default debouncer', () {
    testWidgets('should call function only once', (WidgetTester tester) async {
      final debouncer = Debouncer(const Duration(milliseconds: 10));
      final result = <int>[];

      debouncer.run(() {
        result.add(1);
      });
      debouncer.run(() {
        result.add(2);
      });
      debouncer.run(() {
        result.add(3);
      });

      await tester.pump(const Duration(milliseconds: 9));
      expect(result, []);
      await tester.pump(const Duration(milliseconds: 2));
      expect(result, [3]);
    });
  });
}
