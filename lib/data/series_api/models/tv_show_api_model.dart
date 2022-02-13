class TvShowApiModel {
  final String id;
  final String name;
  final String? imageUrl;

  /// Sumary in html text
  final String? summary;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> genres;

  TvShowApiModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.summary,
    required this.startDate,
    required this.endDate,
    required this.genres,
  });

  factory TvShowApiModel.fromJson(Map<String, dynamic> json) {
    //TODO test TvShowsApiModel.fromJson
    final startDate = DateTime.tryParse(json['premiered'] ?? '');
    final endDate = DateTime.tryParse(json['ended'] ?? '');
    final genres =
        (json['genres'] as Iterable?)?.map((e) => e.toString()).toList();

    return TvShowApiModel(
      id: json['id'].toString(),
      name: json['name'],
      imageUrl: json['image']?['original'],
      summary: json['summary'],
      startDate: startDate,
      endDate: endDate,
      genres: genres ?? [],
    );
  }
}
