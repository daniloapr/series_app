import 'package:series_app/models/tv_show.dart';

abstract class HomeState {
  abstract final List<TvShow> list;

  const HomeState();
}

class HomeLoadingState extends HomeState {
  @override
  final List<TvShow> list;

  const HomeLoadingState({required this.list});
}

class HomeSuccessState extends HomeState {
  @override
  final List<TvShow> list;

  const HomeSuccessState({required this.list});
}

class HomeErrorState extends HomeState {
  @override
  List<TvShow> get list => [];
}
