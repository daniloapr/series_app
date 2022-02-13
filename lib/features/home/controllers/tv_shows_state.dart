import 'package:equatable/equatable.dart';
import 'package:series_app/models/tv_show.dart';

abstract class TvShowsState extends Equatable {
  abstract final List<TvShow> list;

  const TvShowsState();
}

class TvShowsLoadingState extends TvShowsState {
  @override
  final List<TvShow> list;

  const TvShowsLoadingState({required this.list});

  @override
  List<Object?> get props => [list];
}

class TvShowsSuccessState extends TvShowsState {
  @override
  final List<TvShow> list;

  const TvShowsSuccessState({required this.list});

  @override
  List<Object?> get props => [list];
}

class TvShowsErrorState extends TvShowsState {
  @override
  List<TvShow> get list => [];

  @override
  List<Object?> get props => [list];
}
