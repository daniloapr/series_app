import 'package:flutter/material.dart';
import 'package:series_app/constants/strings.dart';

class SeasonTitle extends StatelessWidget {
  final int seasonNumber;
  const SeasonTitle({
    Key? key,
    required this.seasonNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '${Strings.season} $seasonNumber',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
