import 'package:flutter/material.dart';
import 'package:series_app/constants/dimens.dart';

class DetailsTitle extends StatelessWidget {
  final String tvShowName;
  const DetailsTitle({Key? key, required this.tvShowName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontalPadding),
      child: Text(
        tvShowName,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
