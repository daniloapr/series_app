import 'package:flutter/material.dart';
import 'package:series_app/constants/colors.dart';
import 'package:series_app/features/details/episodes/components/episodes_item.dart';
import 'package:series_app/features/details/episodes/components/season_title.dart';
import 'package:series_app/models/episode.dart';

class EpisodesList extends StatelessWidget {
  final List<Episode> list;
  const EpisodesList({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];

        return Column(
          children: [
            Visibility(
              visible: index == 0 || list[index - 1].season != item.season,
              child: SeasonTitle(seasonNumber: item.season),
            ),
            EpisodeItem(episode: item),
          ],
        );
      },
    );
  }
}
