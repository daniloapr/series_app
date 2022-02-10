import 'package:series_app/data/series_api/models/series_api_model.dart';

class TvShow {
  final String id;
  final String name;
  final String imageMediumUrl;
  final String imageOriginalUrl;

  /// Sumary in html text
  final String summary;
  final DateTime startDate;
  final DateTime? endDate;
  final List<String> genres;
  // date start
  // date end
  // genres list
  // episodes list

  TvShow({
    required this.id,
    required this.name,
    required this.imageMediumUrl,
    required this.imageOriginalUrl,
    required this.summary,
    required this.startDate,
    required this.endDate,
    required this.genres,
  });

  factory TvShow.fromApi(SeriesApiModel apiModel) {
    return TvShow(
      id: apiModel.id,
      name: apiModel.name,
      imageMediumUrl: apiModel.imageMediumUrl,
      imageOriginalUrl: apiModel.imageOriginalUrl,
      summary: apiModel.summary,
      startDate: apiModel.startDate,
      endDate: apiModel.endDate,
      genres: [],
    );
  }
}
