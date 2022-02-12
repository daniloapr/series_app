import 'package:flutter/material.dart';
import 'package:series_app/constants/dimens.dart';
import 'package:series_app/constants/strings.dart';
import 'package:series_app/features/details/components/details_item.dart';
import 'package:series_app/features/details/components/details_name.dart';
import 'package:series_app/features/details/components/details_poster.dart';
import 'package:series_app/features/details/components/episodes_list.dart';
import 'package:series_app/features/home/components/app_back_button.dart';
import 'package:series_app/models/tv_show.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsScreen extends StatefulWidget {
  final TvShow tvShow;
  const DetailsScreen({Key? key, required this.tvShow}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              key: Key('BackButton'),
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Dimens.horizontalPadding,
                    top: 20,
                  ),
                  child: AppBackButton(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DetailsPoster(tvShow: widget.tvShow),
            const SizedBox(height: 30),
            DetailsTitle(tvShowName: widget.tvShow.name),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.horizontalPadding - 6,
              ),
              child: Html(
                key: const Key('Summary'),
                data: widget.tvShow.summary ?? '',
              ),
            ),
            const SizedBox(height: 16),
            DetailsItem(
              title: Strings.genre,
              content: genresText(widget.tvShow.genres),
            ),
            const SizedBox(height: 8),
            DetailsItem(
              title: Strings.premiered,
              content: premieredText(
                startDate: widget.tvShow.startDate,
                endDate: widget.tvShow.endDate,
              ),
            ),
            const EpisodesList(),
          ],
        ),
      ),
    );
  }
}

@visibleForTesting
String genresText(List<String> genres) {
  String text = '';

  for (var i = 0; i < genres.length; i++) {
    text += genres[i];
    if (i != genres.length - 1) {
      text += ', ';
    }
  }

  return text;
}

@visibleForTesting
String premieredText({DateTime? startDate, DateTime? endDate}) {
  if (startDate == null) {
    return Strings.never;
  }

  final startMonth = startDate.month.toString().padLeft(2, '0');
  final startDay = startDate.day.toString().padLeft(2, '0');
  final startDateText = '${startDate.year}/$startMonth/$startDay';

  if (endDate == null) {
    return '$startDateText until now';
  }

  final endMonth = endDate.month.toString().padLeft(2, '0');
  final endDay = endDate.day.toString().padLeft(2, '0');
  final endDateText = '${endDate.year}/$endMonth/$endDay';

  return '$startDateText - $endDateText';
}
