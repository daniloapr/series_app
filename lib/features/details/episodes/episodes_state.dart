import 'package:series_app/models/episode.dart';

abstract class EpisodesState {
  const EpisodesState();
}

class EpisodesLoadingState extends EpisodesState {}

class EpisodesSuccessState extends EpisodesState {
  final List<Episode> list;

  const EpisodesSuccessState({required this.list});
}

class EpisodesErrorState extends EpisodesState {}
