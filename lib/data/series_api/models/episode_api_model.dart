class EpisodeApiModel {
  final String name;
  final int number;
  final int season;
  final String? summary;
  final String? imageUrl;

  EpisodeApiModel({
    required this.name,
    required this.number,
    required this.season,
    this.summary,
    this.imageUrl,
  });

  factory EpisodeApiModel.fromJson(Map<String, dynamic> json) {
    return EpisodeApiModel(
      name: json['name'],
      number: json['number'],
      season: json['season'],
      summary: json['summary'],
      imageUrl: json['image']?['original'],
    );
  }
}
