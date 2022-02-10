import 'package:flutter/material.dart';
import 'package:series_app/models/tv_show.dart';

class TvShowItem extends StatelessWidget {
  final TvShow tvShow;
  const TvShowItem({Key? key, required this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.zero,
        color: Colors.amber,
        child: Image.network(tvShow.imageUrl),
      ),
    );
  }
}
