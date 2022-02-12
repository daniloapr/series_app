import 'package:flutter_test/flutter_test.dart';
import 'package:series_app/features/details/details_screen.dart';

void main() {
  group('genresText', () {
    /// MapEntry(input, expected).
    final genresVariant = ValueVariant<MapEntry<List<String>, String>>({
      const MapEntry(['Comedy'], 'Comedy'),
      const MapEntry(['Comedy', 'Horror', 'Action'], 'Comedy, Horror, Action'),
      const MapEntry([], ''),
    });
    testWidgets('returns properly', (WidgetTester tester) async {
      expect(
        genresText(genresVariant.currentValue!.key),
        genresVariant.currentValue!.value,
      );
    }, variant: genresVariant);
  });

  group('premieredText', () {
    /// MapEntry(input: [startDate, endDate], expected).
    final premieredVariant = ValueVariant<MapEntry<List<DateTime?>, String>>({
      const MapEntry([null, null], 'Never'),
      MapEntry([DateTime(2022, 01, 01), null], '2022/01/01 until now'),
      MapEntry(
        [DateTime(2020, 01, 01), DateTime(2022, 02, 12)],
        '2020/01/01 - 2022/02/12',
      ),
    });
    testWidgets('returns properly', (WidgetTester tester) async {
      final startDate = premieredVariant.currentValue!.key[0];
      final endDate = premieredVariant.currentValue!.key[1];
      expect(
        premieredText(startDate: startDate, endDate: endDate),
        premieredVariant.currentValue!.value,
      );
    }, variant: premieredVariant);
  });
}
