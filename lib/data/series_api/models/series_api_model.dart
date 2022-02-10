class SeriesApiModel {
  final String id;
  final String name;
  final String imageMediumUrl;
  final String imageOriginalUrl;

  /// Sumary in html text
  final String summary;
  final DateTime startDate;
  final DateTime? endDate;
  // date start
  // date end
  // genres list
  // episodes list

  SeriesApiModel({
    required this.id,
    required this.name,
    required this.imageMediumUrl,
    required this.imageOriginalUrl,
    required this.summary,
    required this.startDate,
    required this.endDate,
  });

  factory SeriesApiModel.fromJson(Map<String, dynamic> json) {
    print(json['id']);
    final startDate = DateTime.parse(json['premiered']);
    final endDate = DateTime.tryParse(json['ended'] ?? '');

    return SeriesApiModel(
      id: json['id'].toString(),
      name: json['name'],
      imageMediumUrl: json['image']['medium'],
      imageOriginalUrl: json['image']['original'],
      summary: json['summary'],
      startDate: startDate,
      endDate: endDate,
    );
  }
}
