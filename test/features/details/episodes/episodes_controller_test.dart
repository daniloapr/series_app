import 'package:flutter_test/flutter_test.dart';
import 'package:series_app/features/details/episodes/episodes_controller.dart';
import 'package:series_app/models/episode.dart';

void main() {
  group('getSeasonLength', () {
    test('returns properly', () {
      final episodes = [
        Episode(name: '1-1', number: 1, season: 1),
        Episode(name: '2-1', number: 2, season: 1),
        Episode(name: '3-1', number: 3, season: 1),
        Episode(name: '1-2', number: 1, season: 2),
        Episode(name: '1-3', number: 1, season: 3),
        Episode(name: '2-3', number: 2, season: 3),
      ];

      expect(EpisodesController.getSeasonLength(episodes), 3);
    });
  });
}
