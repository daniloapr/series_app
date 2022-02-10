import 'package:flutter/material.dart';
import 'package:series_app/features/home/components/genres_text.dart';
import 'package:series_app/models/tv_show.dart';

class TvShowItem extends StatelessWidget {
  final TvShow tvShow;

  const TvShowItem({Key? key, required this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        children: [
          Hero(
            tag: '${tvShow.id} TvShowImage',
            child: Image.network(
              tvShow.imageUrl,
              key: Key('${tvShow.id} TvShowImage'),
            ),
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
                  //TODO: navigate to details screen
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
