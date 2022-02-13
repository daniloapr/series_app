import 'package:series_app/models/episode.dart';

abstract class EpisodesState {
  const EpisodesState();
}

class EpisodesLoadingState extends EpisodesState {}

class EpisodesSuccessState extends EpisodesState {
  /// Filtered list of episodes by season
  final List<Episode> list;
  final int selectedSeason;
  final int seasonLength;

  const EpisodesSuccessState({
    required this.list,
    required this.selectedSeason,
    required this.seasonLength,
  });
}

class EpisodesErrorState extends EpisodesState {}
