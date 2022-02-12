import 'package:flutter/material.dart';
import 'package:series_app/features/home/components/poster_image.dart';
import 'package:series_app/models/tv_show.dart';

class DetailsPoster extends StatelessWidget {
  final TvShow tvShow;
  const DetailsPoster({Key? key, required this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80.0),
        child: PosterImage(
          id: tvShow.id,
          imageUrl: tvShow.imageUrl,
        ),
      ),
    );
  }
}
