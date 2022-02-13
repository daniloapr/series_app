import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:series_app/components/error_view.dart';
import 'package:series_app/constants/dimens.dart';
import 'package:series_app/constants/strings.dart';
import 'package:series_app/features/details/components/details_item.dart';
import 'package:series_app/features/details/components/details_name.dart';
import 'package:series_app/features/details/components/details_poster.dart';
import 'package:series_app/features/details/episodes/episodes_controller.dart';
import 'package:series_app/features/details/episodes/components/episodes_list.dart';
import 'package:series_app/features/details/episodes/episodes_state.dart';
import 'package:series_app/features/home/components/app_back_button.dart';
import 'package:series_app/models/tv_show.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:series_app/service_locator.dart';

class DetailsScreen extends StatefulWidget {
  final TvShow tvShow;
  const DetailsScreen({Key? key, required this.tvShow}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _episodesController = locator<EpisodesController>();

  @override
  void initState() {
    super.initState();
    _episodesController.fetchEpisodes(widget.tvShow.id);
  }

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
              key: const Key('Summary'),
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.horizontalPadding - 6,
              ),
              child: Html(
                data: widget.tvShow.summary ?? '',
              ),
            ),
            const SizedBox(height: 16),
            DetailsItem(
              key: const Key('Genres'),
              title: Strings.genre,
              content: genresText(widget.tvShow.genres),
            ),
            const SizedBox(height: 8),
            DetailsItem(
              key: const Key('Premiered'),
              title: Strings.premiered,
              content: premieredText(
                startDate: widget.tvShow.startDate,
                endDate: widget.tvShow.endDate,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.horizontalPadding,
              ),
              child: StreamBuilder<EpisodesState>(
                key: const Key('Episodes'),
                stream: _episodesController.stateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;

                  if (state is EpisodesSuccessState) {
                    return EpisodesList(
                      list: state.list,
                      seasonLength: state.seasonLength,
                      selectedSeason: state.selectedSeason,
                      onSeasonSelected: (season) {
                        _episodesController.changeSeason(season);
                      },
                    );
                  } else if (state is EpisodesLoadingState) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  } else if (state is EpisodesErrorState) {
                    return ErrorView(
                      errorText: Strings.errorFetchingEpisodes,
                      onPressed: () =>
                          _episodesController.fetchEpisodes(widget.tvShow.id),
                    );
                  }

                  return Container();
                },
              ),
            ),
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

  final startDateText = DateFormat('yyyy/MM/dd').format(startDate);

  if (endDate == null) {
    return '$startDateText ${Strings.untilToday.toLowerCase()}';
  }

  final endDateText = DateFormat('yyyy/MM/dd').format(endDate);

  return '$startDateText - $endDateText';
}
