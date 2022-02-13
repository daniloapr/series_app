import 'package:mocktail/mocktail.dart';
import 'package:series_app/data/series_api/models/tv_show_api_model.dart';
import 'package:series_app/data/series_api/series_api.dart';

class SeriesApiMock extends Mock implements SeriesApi {}

TvShowApiModel mockTvShowApiModel({String? id, String? name}) {
  return TvShowApiModel(
    id: id ?? 'id',
    name: name ?? 'name',
    imageUrl: 'imageUrl',
    summary: 'summary',
    startDate: DateTime(2020),
    endDate: DateTime(2021),
    genres: const ['Commedy'],
  );
}
