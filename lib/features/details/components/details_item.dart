import 'package:flutter/material.dart';
import 'package:series_app/constants/colors.dart';
import 'package:series_app/constants/dimens.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DetailsItem extends StatelessWidget {
  final String title;
  final String content;
  const DetailsItem({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontalPadding),
      child: Row(
        children: [
          Expanded(
            flex: 35,
            child: AutoSizeText(
              title,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.black54),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 65,
            child: Text(
              content,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
