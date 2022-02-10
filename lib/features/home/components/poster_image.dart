import 'package:flutter/material.dart';
import 'package:series_app/constants/dimens.dart';

class PosterImage extends StatelessWidget {
  final String id;
  final String imageUrl;
  const PosterImage({
    Key? key,
    required this.id,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '$id TvShowImage',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.cardRadius),
        child: Image.network(imageUrl),
      ),
    );
  }
}
