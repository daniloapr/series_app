import 'package:series_app/data/series_api/models/episode_api_model.dart';

class Episode {
  final String name;
  final int number;
  final int season;
  final String? summary;
  final String? imageUrl;
  final DateTime? airDate;

  Episode({
    required this.name,
    required this.number,
    required this.season,
    this.summary,
    this.imageUrl,
    this.airDate,
  });

  factory Episode.fromApi(EpisodeApiModel apiModel) {
    return Episode(
      name: apiModel.name,
      number: apiModel.number,
      season: apiModel.season,
      imageUrl: apiModel.imageUrl,
      summary: apiModel.summary,
      airDate: apiModel.airDate,
    );
  }
}
