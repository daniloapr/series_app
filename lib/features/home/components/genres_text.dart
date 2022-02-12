import 'package:flutter/material.dart';
import 'package:series_app/constants/colors.dart';

class GenresText extends StatelessWidget {
  final List<String> genres;
  const GenresText({
    Key? key,
    required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        String genresText = '';
        final lastIndex = genres.length - 1;

        for (var i = 0; i <= lastIndex; i++) {
          genresText += genres[i];

          if (i != lastIndex) {
            //add hifen
            genresText += ' · ';
          }
        }
        return Text(
          genresText,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: AppColors.white),
        );
      },
    );
  }
}
