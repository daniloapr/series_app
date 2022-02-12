import 'package:dio/dio.dart';
import 'package:series_app/data/series_api/models/tv_shows_api_model.dart';

class SeriesApi {
  static const _baseUrl = 'https://api.tvmaze.com';

  /// Get a list of TV shows.
  ///
  /// @params:
  /// [search] - Filter the list searching by the serie's name.
  Future<List<TvShowsApiModel>> getShows() async {
    try {
      final response = await Dio().get('$_baseUrl/shows');

      return (response.data as Iterable)
          .map((e) => TvShowsApiModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TvShowsApiModel>> searchShows(String value) async {
    try {
      final response = await Dio().get('$_baseUrl/search/shows?q=$value');

      return (response.data as Iterable)
          .map((e) => TvShowsApiModel.fromJson(e['show']))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
