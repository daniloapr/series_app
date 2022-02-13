import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:series_app/assets/images/images.dart';
import 'package:series_app/constants/dimens.dart';
import 'package:series_app/constants/strings.dart';

class EpisodeImage extends StatelessWidget {
  final String? imageUrl;
  const EpisodeImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
            imageUrl: imageUrl!,
            placeholder: (context, url) => const AspectRatio(
              aspectRatio: Dimens.episodeImageAspectRatio,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          )
        : AspectRatio(
            aspectRatio: Dimens.episodeImageAspectRatio,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.logo,
                  width: 50,
                ),
                const SizedBox(height: 16),
                const Text(Strings.noImageFound),
              ],
            ),
          );
  }
}
