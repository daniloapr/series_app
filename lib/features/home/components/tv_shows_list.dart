import 'package:flutter/material.dart';
import 'package:series_app/constants/dimens.dart';
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
        final isLastItem = index == list.length - 1;

        return Padding(
          padding: EdgeInsets.only(
            top: 16.0,
            left: Dimens.listHorizontalPadding,
            right: Dimens.listHorizontalPadding,
            bottom: isLastItem ? 16.0 : 0.0,
          ),
          child: TvShowItem(tvShow: item),
        );
      },
    );
  }
}
