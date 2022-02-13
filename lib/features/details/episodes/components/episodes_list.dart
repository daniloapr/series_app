import 'package:flutter/material.dart';
import 'package:series_app/constants/colors.dart';
import 'package:series_app/features/details/episodes/components/episodes_item.dart';
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
        return EpisodeItem(episode: item);
      },
    );
  }
}
