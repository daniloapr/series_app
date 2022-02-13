import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_app/data/series_api/models/tv_show_api_model.dart';
import 'package:series_app/data/series_api/series_api.dart';

import 'series_api_mock.dart';

class DioMock extends Mock implements Dio {}

const _baseUrl = 'https://api.tvmaze.com';

void main() {
  final dio = DioMock();
  setUpAll(() {
    GetIt.I.registerFactory<Dio>(() => dio);
  });

  setUp(() {
    reset(dio);
  });
  group('getShows', () {
    test('returns properly', () async {
      final seriesApi = SeriesApi();

      when(() => dio.get(any())).thenAnswer((invocation) async {
        return Response(
          data: [
            {
              'id': '1',
              'name': 'name',
              'image': {
                'original': 'originalUrl',
              },
              'summary': 'summary',
              'premiered': '2020-10-01',
              'ended': '2021-01-01',
              'genres': ['1', '2', '3'],
            }
          ],
          requestOptions: RequestOptions(path: ''),
        );
      });

      final response = await seriesApi.getShows();

      verify(() => dio.get('$_baseUrl/shows')).called(1);

      expect(response, [
        TvShowApiModel(
          id: '1',
          name: 'name',
          imageUrl: 'originalUrl',
          summary: 'summary',
          startDate: DateTime(2020, 10, 01),
          endDate: DateTime(2021),
          genres: const ['1', '2', '3'],
        )
      ]);
    });

    test('returns properly with null values', () async {
      final seriesApi = SeriesApi();

      when(() => dio.get(any())).thenAnswer((invocation) async {
        return Response(
          data: [
            {
              'id': '1',
              'name': 'name',
            }
          ],
          requestOptions: RequestOptions(path: ''),
        );
      });

      final response = await seriesApi.getShows();

      verify(() => dio.get('$_baseUrl/shows')).called(1);

      expect(response, [
        const TvShowApiModel(
          id: '1',
          name: 'name',
          imageUrl: null,
          summary: null,
          startDate: null,
          endDate: null,
          genres: [],
        )
      ]);
    });
  });
}
