import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:series_app/assets/images/images.dart';
import 'package:series_app/constants/dimens.dart';
import 'package:series_app/constants/strings.dart';

class PosterImage extends StatelessWidget {
  final String id;
  final String? imageUrl;
  const PosterImage({
    Key? key,
    required this.id,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '$id TvShowImage',
      // The `Material` widget is necessary to prevent text rendenring errors during the Hero animation.
      child: Material(
        child: Container(
          constraints: const BoxConstraints(maxWidth: Dimens.posterMaxWidth),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.cardRadius),
            child: imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    placeholder: (context, url) {
                      return const AspectRatio(
                        key: Key('PosterImageLoading'),
                        aspectRatio: Dimens.posterAspectRatio,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    },
                  )
                : AspectRatio(
                    key: const Key('PosterImagePlaceholder'),
                    aspectRatio: Dimens.posterAspectRatio,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.logo,
                          width: 100,
                        ),
                        const SizedBox(height: 16),
                        const Text(Strings.noImageFound),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
