import 'package:flutter/material.dart';
import 'package:series_app/constants/dimens.dart';
import 'package:series_app/features/details/details_screen.dart';
import 'package:series_app/features/home/components/genres_text.dart';
import 'package:series_app/features/home/components/poster_image.dart';
import 'package:series_app/models/tv_show.dart';

class TvShowItem extends StatelessWidget {
  final TvShow tvShow;

  const TvShowItem({Key? key, required this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.cardRadius),
      child: Stack(
        children: [
          PosterImage(
            id: tvShow.id,
            imageUrl: tvShow.imageUrl,
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 1],
                  colors: [
                    Colors.transparent,
                    Colors.black87,
                  ],
                ),
              ),
              padding: EdgeInsets.zero,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tvShow.name,
                  key: Key('${tvShow.id} NameText'),
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                GenresText(
                  key: Key('${tvShow.id} GenresText'),
                  genres: tvShow.genres,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // In a regular project, I would create a router file and use
                  // the `pushNamed` method instead.
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(tvShow: tvShow),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
