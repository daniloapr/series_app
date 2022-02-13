import 'package:series_app/models/tv_show.dart';

abstract class TvShowState {
  abstract final List<TvShow> list;

  const TvShowState();
}

class TvShowLoadingState extends TvShowState {
  @override
  final List<TvShow> list;

  const TvShowLoadingState({required this.list});
}

class TvShowSuccessState extends TvShowState {
  @override
  final List<TvShow> list;

  const TvShowSuccessState({required this.list});
}

class HomeErrorState extends TvShowState {
  @override
  List<TvShow> get list => [];
}
