import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_app/data/series_api/models/tv_show_api_model.dart';
import 'package:series_app/data/series_api/series_api.dart';
import 'package:series_app/features/home/controllers/tv_shows_controller.dart';
import 'package:series_app/features/home/controllers/tv_shows_state.dart';
import 'package:series_app/models/tv_show.dart';

import '../../../data/series_api/series_api_mock.dart';

void main() {
  group('fetchTvSeries', () {
    test('emits sucess state properly', () async {
      final seriesApi = SeriesApiMock();
      GetIt.I.registerFactory<SeriesApi>(() => seriesApi);
      final List<TvShowsState> states = [];

      when(() => seriesApi.getShows()).thenAnswer((invocation) async => [
            TvShowApiModel(
              id: '1',
              name: 'name',
              imageUrl: 'imageUrl',
              summary: 'summary',
              startDate: DateTime(2020),
              endDate: DateTime(2021),
              genres: ['Commedy'],
            )
          ]);

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
        TvShowsSuccessState(list: [
          TvShow(
            id: '1',
            name: 'name',
            imageUrl: 'imageUrl',
            summary: 'summary',
            startDate: DateTime(2020),
            endDate: DateTime(2021),
            genres: const ['Commedy'],
          )
        ]),
      ]);
    });

    test('emits error state properly on API exception', () async {
      final seriesApi = SeriesApiMock();
      GetIt.I.registerFactory<SeriesApi>(() => seriesApi);
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
        // Duplicate due to the initial state being Loading
        const TvShowsLoadingState(list: []),
        TvShowsErrorState(),
      ]);
    });
  });

  group('search', () {
    test('emits sucess state properly', () async {
      final seriesApi = SeriesApiMock();
      GetIt.I.registerFactory<SeriesApi>(() => seriesApi);
      final List<TvShowsState> states = [];

      when(() => seriesApi.searchShows(any()))
          .thenAnswer((invocation) async => [
                TvShowApiModel(
                  id: '1',
                  name: 'name',
                  imageUrl: 'imageUrl',
                  summary: 'summary',
                  startDate: DateTime(2020),
                  endDate: DateTime(2021),
                  genres: ['Commedy'],
                )
              ]);

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
        TvShowsSuccessState(list: [
          TvShow(
            id: '1',
            name: 'name',
            imageUrl: 'imageUrl',
            summary: 'summary',
            startDate: DateTime(2020),
            endDate: DateTime(2021),
            genres: const ['Commedy'],
          )
        ]),
      ]);
    });

    test('emits error state properly on exception', () async {
      final seriesApi = SeriesApiMock();
      GetIt.I.registerFactory<SeriesApi>(() => seriesApi);
      final List<TvShowsState> states = [];

      when(() => seriesApi.searchShows(any()))
          .thenAnswer((invocation) async => throw Exception('Api error.'));

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
        TvShowsErrorState(),
      ]);
    });
  });
}
