import 'package:flutter/material.dart';
import 'package:series_app/constants/strings.dart';
import 'package:series_app/features/details/episodes/components/episodes_item.dart';
import 'package:series_app/features/details/episodes/components/season_dropdown.dart';
import 'package:series_app/models/episode.dart';

class EpisodesList extends StatelessWidget {
  final List<Episode> list;
  final int selectedSeason;
  final int seasonLength;
  final Function(int season) onSeasonSelected;
  const EpisodesList({
    Key? key,
    required this.list,
    required this.selectedSeason,
    required this.onSeasonSelected,
    required this.seasonLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeasonDropdown(
          seasonLength: seasonLength,
          currentSeason: selectedSeason,
          onSeasonSelected: onSeasonSelected,
        ),
        const SizedBox(height: 20),
        Text(
          '${Strings.episodes} (${list.length})',
          style: Theme.of(context).textTheme.headline6,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];

            return EpisodeItem(episode: item);
          },
        ),
      ],
    );
  }
}
