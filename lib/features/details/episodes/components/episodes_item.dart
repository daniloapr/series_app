import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:series_app/constants/colors.dart';
import 'package:series_app/features/details/episodes/components/episode_image.dart';
import 'package:series_app/models/episode.dart';

class EpisodeItem extends StatelessWidget {
  final Episode episode;
  static const _padding = 8.0;
  const EpisodeItem({
    Key? key,
    required this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.greyLight,
      elevation: 0,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(_padding),
        title: Text('${episode.number}. ${episode.name}'),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: _padding),
              Expanded(
                flex: 2,
                child: EpisodeImage(imageUrl: episode.imageUrl),
              ),
              const SizedBox(width: _padding),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (episode.airDate != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: AutoSizeText(
                            getAirDateText(episode.airDate!),
                            maxLines: 1,
                          ),
                        ),
                      AutoSizeText(
                        'Season ${episode.season}',
                        maxLines: 1,
                      )
                    ],
                  )),
              const SizedBox(width: _padding),
            ],
          ),
          Html(data: episode.summary ?? ''),
        ],
      ),
    );
  }
}

String getAirDateText(DateTime airDate) {
  return DateFormat('yyyy/MM/dd').format(airDate);
}
