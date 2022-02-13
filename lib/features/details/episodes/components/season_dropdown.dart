import 'package:flutter/material.dart';
import 'package:series_app/constants/colors.dart';
import 'package:series_app/constants/strings.dart';

class SeasonDropdown extends StatelessWidget {
  final int seasonLength;
  final int currentSeason;
  final Function(int season) onSeasonSelected;

  const SeasonDropdown({
    Key? key,
    required this.seasonLength,
    required this.currentSeason,
    required this.onSeasonSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (_) => List.generate(seasonLength, (index) {
        final season = index + 1;
        return PopupMenuItem(
          child: Text('${Strings.season} $season'),
          onTap: () => onSeasonSelected(season),
        );
      }),
      child: Container(
        color: AppColors.greyLight,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${Strings.season} $currentSeason',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
