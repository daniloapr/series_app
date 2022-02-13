import 'package:dio/dio.dart';
import 'package:series_app/data/series_api/models/episode_api_model.dart';
import 'package:series_app/data/series_api/models/tv_show_api_model.dart';

class SeriesApi {
  static const _baseUrl = 'https://api.tvmaze.com';

  /// Get a list of TV shows.
  ///
  /// @params:
  /// [search] - Filter the list searching by the serie's name.
  Future<List<TvShowApiModel>> getShows() async {
    final response = await Dio().get('$_baseUrl/shows');

    return (response.data as Iterable)
        .map((data) => TvShowApiModel.fromJson(data))
        .toList();
  }

  Future<List<TvShowApiModel>> searchShows(String value) async {
    final response = await Dio().get('$_baseUrl/search/shows?q=$value');

    return (response.data as Iterable)
        .map((data) => TvShowApiModel.fromJson(data['show']))
        .toList();
  }

  Future<List<EpisodeApiModel>> getEpisodes(String showId) async {
    final response = await Dio().get('$_baseUrl/shows/$showId/episodes');

    return (response.data as Iterable)
        .map((data) => EpisodeApiModel.fromJson(data))
        .toList();
  }
}
