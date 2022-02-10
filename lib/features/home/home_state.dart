import 'package:series_app/models/tv_show.dart';

abstract class HomeState {
  const HomeState();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeSuccessState extends HomeState {
  final List<TvShow> list;

  const HomeSuccessState({required this.list});
}

class HomeErrorState extends HomeState {}
