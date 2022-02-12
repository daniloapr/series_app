import 'package:cached_network_image/cached_network_image.dart';
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
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) {
            return const AspectRatio(
              aspectRatio: Dimens.posterAspectRatio,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          },
        ),
      ),
    );
  }
}
