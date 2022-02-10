class TvShowsApiModel {
  final String id;
  final String name;
  final String imageUrl;

  /// Sumary in html text
  final String summary;
  final DateTime startDate;
  final DateTime? endDate;
  final List<String> genres;
  // date start
  // date end
  // genres list
  // episodes list

  TvShowsApiModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.summary,
    required this.startDate,
    required this.endDate,
    required this.genres,
  });

  factory TvShowsApiModel.fromJson(Map<String, dynamic> json) {
    final startDate = DateTime.parse(json['premiered']);
    final endDate = DateTime.tryParse(json['ended'] ?? '');
    final genres =
        (json['genres'] as Iterable).map((e) => e.toString()).toList();

    return TvShowsApiModel(
      id: json['id'].toString(),
      name: json['name'],
      imageUrl: json['image']['original'],
      summary: json['summary'],
      startDate: startDate,
      endDate: endDate,
      genres: genres,
    );
  }
}
