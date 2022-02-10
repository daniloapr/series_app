import 'package:dio/dio.dart';
import 'package:series_app/data/series_api/models/series_api_model.dart';

class SeriesApi {
  static const _baseUrl = 'https://api.tvmaze.com';

  /// Get a list of TV shows.
  ///
  /// @params:
  /// [search] - Filter the list searching by the serie's name.
  Future<List<ShowsApiModel>> getShows({String? search}) async {
    try {
      final response = await Dio().get('$_baseUrl/shows');

      return (response.data as Iterable)
          .map((e) => ShowsApiModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
