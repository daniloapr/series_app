import 'package:series_app/models/tv_show.dart';

abstract class HomeState {
  const HomeState();
}

class HomeLoading extends HomeState {
  final List<TvShow> list;

  const HomeLoading({required this.list});
}

class HomeSuccess extends HomeState {
  final List<TvShow> list;

  const HomeSuccess({required this.list});
}

class HomeError extends HomeState {}
