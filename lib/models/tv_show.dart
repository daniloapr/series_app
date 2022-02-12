import 'package:series_app/data/series_api/models/tv_shows_api_model.dart';

class TvShow {
  final String id;
  final String name;
  final String? imageUrl;

  /// Sumary in html text
  final String? summary;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> genres;

  TvShow({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.summary,
    required this.startDate,
    required this.endDate,
    required this.genres,
  });

  factory TvShow.fromApi(TvShowsApiModel apiModel) {
    return TvShow(
      id: apiModel.id,
      name: apiModel.name,
      imageUrl: apiModel.imageUrl,
      summary: apiModel.summary,
      startDate: apiModel.startDate,
      endDate: apiModel.endDate,
      genres: apiModel.genres,
    );
  }
}
