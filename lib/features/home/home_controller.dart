import 'package:rxdart/rxdart.dart';
import 'package:series_app/data/series_api/series_api.dart';
import 'package:series_app/features/home/home_state.dart';
import 'package:series_app/models/tv_show.dart';
import 'package:series_app/service_locator.dart';

class HomeController {
  final _seriesApi = locator<SeriesApi>();
  final _stateController = BehaviorSubject<HomeState>();
  Stream<HomeState> get stateStream => _stateController.stream;

  void dispose() {
    _stateController.close();
  }

  void fetchTvSeries() async {
    try {
      final apiList = await _seriesApi.getShows();

      _stateController.add(
        HomeSuccessState(list: apiList.map((e) => TvShow.fromApi(e)).toList()),
      );
    } catch (e) {
      // Handle error.
      print(e);
    }
  }
}
