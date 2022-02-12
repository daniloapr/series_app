import 'package:rxdart/rxdart.dart';
import 'package:series_app/data/series_api/series_api.dart';
import 'package:series_app/features/home/home_state.dart';
import 'package:series_app/models/tv_show.dart';
import 'package:series_app/service_locator.dart';
import 'package:series_app/utils/debouncer.dart';

class HomeController {
  final _seriesApi = locator<SeriesApi>();
  final _stateController = BehaviorSubject<HomeState>();
  Stream<HomeState> get stateStream => _stateController.stream;

  // 500 ms debouncer prevents the API maximum rate of 20 calls for 10 seconds.
  final _searchDebouncer = Debouncer(const Duration(milliseconds: 500));

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

  void search(String value) async {
    try {
      _searchDebouncer.run(() async {
        if (value.trim().isEmpty) {
          fetchTvSeries();
          return;
        }

        final apiList =await _seriesApi.searchShows(value);

        _stateController.add(
          HomeSuccessState(
            list: apiList.map((e) => TvShow.fromApi(e)).toList(),
          ),
        );
      });
    } catch (e) {
      print(e);
    }
  }
}
