import 'package:flutter/material.dart';
import 'package:series_app/features/home/components/tv_show_item.dart';
import 'package:series_app/models/tv_show.dart';

class TvShowsList extends StatelessWidget {
  final List<TvShow> list;
  const TvShowsList({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];

        return TvShowItem(tvShow: item);
      },
    );
  }
}
