import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_app/constants/durations.dart';
import 'package:series_app/data/series_api/series_api.dart';
import 'package:series_app/features/home/controllers/tv_shows_controller.dart';
import 'package:series_app/features/home/controllers/tv_shows_state.dart';
import 'package:series_app/models/tv_show.dart';

import '../../../data/series_api/series_api_mock.dart';

TvShow mockTvShow({String? id, String? name}) {
  return TvShow(
    id: id ?? 'id',
    name: name ?? 'name',
    imageUrl: 'imageUrl',
    summary: 'summary',
    startDate: DateTime(2020),
    endDate: DateTime(2021),
    genres: const ['Commedy'],
  );
}

void main() {
  final seriesApi = SeriesApiMock();
  setUpAll(() {
    GetIt.I.registerFactory<SeriesApi>(() => seriesApi);
  });

  setUp(() {
    reset(seriesApi);
  });
  group('fetchTvSeries', () {
    test('emits sucess state properly', () async {
      final List<TvShowsState> states = [];

      when(() => seriesApi.getShows()).thenAnswer(
        (invocation) async => [mockTvShowApiModel(id: '1', name: 'name')],
      );

      final tvShowsController = TvShowsController();

      tvShowsController.stateStream.listen((event) {
        states.add(event);
      });

      await tvShowsController.fetchTvSeries();
      await Future.delayed(const Duration(milliseconds: 1));

      expect(states, [
        const TvShowsLoadingState(list: []),
        // Duplicate due to the initial state being Loading
        const TvShowsLoadingState(list: []),
        TvShowsSuccessState(
          list: [mockTvShow(id: '1', name: 'name')],
        ),
      ]);
    });

    test('emits error state properly on API exception', () async {
      final List<TvShowsState> states = [];

      when(() => seriesApi.getShows())
          .thenAnswer((invocation) async => throw Exception('Api error'));

      final tvShowsController = TvShowsController();

      tvShowsController.stateStream.listen((event) {
        states.add(event);
      });

      await tvShowsController.fetchTvSeries();
      await Future.delayed(const Duration(milliseconds: 1));

      expect(states, [
        const TvShowsLoadingState(list: []),
        const TvShowsLoadingState(list: []),
        TvShowsErrorState(),
      ]);
    });
  });

  group('search', () {
    test('emits sucess state properly', () async {
      final List<TvShowsState> states = [];
      when(() => seriesApi.searchShows(any())).thenAnswer(
        (invocation) async => [mockTvShowApiModel(id: '1', name: 'name')],
      );

      final tvShowsController = TvShowsController();

      tvShowsController.stateStream.listen((event) {
        states.add(event);
      });

      await tvShowsController.search('Spider Man');

      // Still loading due to debouncing
      await Future.delayed(const Duration(milliseconds: 100));
      verifyNever(() => seriesApi.searchShows(any()));
      expect(tvShowsController.state, const TvShowsLoadingState(list: []));

      // Wait for debouncing time
      await Future.delayed(const Duration(milliseconds: 100));
      verify(() => seriesApi.searchShows('Spider Man')).called(1);

      expect(states, [
        const TvShowsLoadingState(list: []),
        const TvShowsLoadingState(list: []),
        TvShowsSuccessState(
          list: [mockTvShow(id: '1', name: 'name')],
        ),
      ]);
    });

    test('emits error state properly on exception', () async {
      final List<TvShowsState> states = [];

      when(() => seriesApi.searchShows(any()))
          .thenAnswer((invocation) async => throw Exception('Api error.'));

      final tvShowsController = TvShowsController();

      tvShowsController.stateStream.listen((event) {
        states.add(event);
      });

      await tvShowsController.search('Spider Man');

      // Wait for debouncing time
      await Future.delayed(Durations.searchDebbounce);
      verify(() => seriesApi.searchShows('Spider Man')).called(1);
      await Future.delayed(const Duration(milliseconds: 1));

      expect(states, [
        const TvShowsLoadingState(list: []),
        const TvShowsLoadingState(list: []),
        TvShowsErrorState(),
      ]);
    });

    test('should call getShows() when search is empty', () async {
      final List<TvShowsState> states = [];

      when(() => seriesApi.getShows()).thenAnswer(
        (invocation) async => [mockTvShowApiModel(id: '1', name: 'name')],
      );

      final tvShowsController = TvShowsController();

      tvShowsController.stateStream.listen((event) {
        states.add(event);
      });

      await tvShowsController.search('');

      // Wait for debouncing
      await Future.delayed(Durations.searchDebbounce);
      verifyNever(() => seriesApi.searchShows(any()));
      verify(() => seriesApi.getShows()).called(1);

      await Future.delayed(const Duration(milliseconds: 1));

      expect(states, [
        const TvShowsLoadingState(list: []),
        const TvShowsLoadingState(list: []),
        TvShowsSuccessState(
          list: [mockTvShow(id: '1', name: 'name')],
        ),
      ]);
    });
  });

  group('Cancelling api calls', () {
    test('should cancel the first search and emit the state of the second one',
        () async {
      final List<TvShowsState> states = [];

      when(() => seriesApi.searchShows('Spider Man')).thenAnswer(
        (invocation) async {
          await Future.delayed(const Duration(milliseconds: 1000));
          return [mockTvShowApiModel(id: '1', name: 'Spider Man')];
        },
      );

      when(() => seriesApi.searchShows('Iron Man')).thenAnswer(
        (invocation) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return [mockTvShowApiModel(id: '2', name: 'Iron Man')];
        },
      );

      final tvShowsController = TvShowsController();

      tvShowsController.stateStream.listen((event) {
        states.add(event);
      });

      await tvShowsController.search('Spider Man');

      // Waits for the debouncing
      await Future.delayed(Durations.searchDebbounce);
      verify(() => seriesApi.searchShows('Spider Man')).called(1);

      // Call search before the first one returned
      await tvShowsController.search('Iron Man');
      await Future.delayed(Durations.searchDebbounce);
      verify(() => seriesApi.searchShows('Iron Man')).called(1);

      // Wait for search return
      await Future.delayed(const Duration(milliseconds: 150));

      expect(states, [
        const TvShowsLoadingState(list: []),
        const TvShowsLoadingState(list: []),
        const TvShowsLoadingState(list: []),
        TvShowsSuccessState(list: [mockTvShow(id: '2', name: 'Iron Man')]),
      ]);
    });
  });
}
