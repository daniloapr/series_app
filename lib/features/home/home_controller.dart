import 'package:rxdart/rxdart.dart';
import 'package:series_app/data/series_api/series_api.dart';
import 'package:series_app/features/home/home_state.dart';
import 'package:series_app/models/tv_show.dart';
import 'package:series_app/service_locator.dart';
import 'package:series_app/utils/debouncer.dart';
import 'package:uuid/uuid.dart';

class HomeController {
  final _seriesApi = locator<SeriesApi>();
  final _stateController =
      BehaviorSubject<HomeState>.seeded(const HomeLoadingState(list: []));
  Stream<HomeState> get stateStream => _stateController.stream;
  HomeState get state => _stateController.value;

  final _searchDebouncer = Debouncer(const Duration(milliseconds: 200));
  String _lastSearchId = '';

  void dispose() {
    _stateController.close();
  }

  void fetchTvSeries() async {
    try {
      _stateController.add(
        HomeLoadingState(list: state.list),
      );

      _lastSearchId = const Uuid().v4().toString();
      final currentSearchId = _lastSearchId;
      final apiList = await _seriesApi.getShows();

      if (_lastSearchId == currentSearchId) {
        _stateController.add(
          HomeSuccessState(
            list: apiList.map((e) => TvShow.fromApi(e)).toList(),
          ),
        );
      }
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

        _stateController.add(
          HomeLoadingState(list: state.list),
        );

        // _lastSearchId can be changed by the next call, invalidating this one.
        _lastSearchId = const Uuid().v4().toString();
        final currentSearchId = _lastSearchId;
        final apiList = await _seriesApi.searchShows(value);

        if (_lastSearchId == currentSearchId) {
          _stateController.add(
            HomeSuccessState(
              list: apiList.map((e) => TvShow.fromApi(e)).toList(),
            ),
          );
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
