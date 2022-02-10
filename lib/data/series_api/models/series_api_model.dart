class ShowsApiModel {
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

  ShowsApiModel({
    required this.id,
    required this.name,
    required this.imageMediumUrl,
    required this.imageOriginalUrl,
    required this.summary,
    required this.startDate,
    required this.endDate,
  });

  factory ShowsApiModel.fromJson(Map<String, dynamic> json) {
    final startDate = DateTime.parse(json['premiered']);
    final endDate = DateTime.tryParse(json['ended'] ?? '');

    return ShowsApiModel(
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
