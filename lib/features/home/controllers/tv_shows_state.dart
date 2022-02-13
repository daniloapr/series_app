import 'package:series_app/models/tv_show.dart';

abstract class TvShowsState {
  abstract final List<TvShow> list;

  const TvShowsState();
}

class TvShowsLoadingState extends TvShowsState {
  @override
  final List<TvShow> list;

  const TvShowsLoadingState({required this.list});
}

class TvShowsSuccessState extends TvShowsState {
  @override
  final List<TvShow> list;

  const TvShowsSuccessState({required this.list});
}

class TvShowsErrorState extends TvShowsState {
  @override
  List<TvShow> get list => [];
}
