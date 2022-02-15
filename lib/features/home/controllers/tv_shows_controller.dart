import 'package:rxdart/rxdart.dart';
import 'package:series_app/constants/durations.dart';
import 'package:series_app/data/series_api/series_api.dart';
import 'package:series_app/features/home/controllers/tv_shows_state.dart';
import 'package:series_app/models/tv_show.dart';
import 'package:series_app/service_locator.dart';
import 'package:series_app/utils/debouncer.dart';
import 'package:uuid/uuid.dart';

class TvShowsController {
  final _seriesApi = locator<SeriesApi>();
  final _stateController =
      BehaviorSubject<TvShowsState>.seeded(const TvShowsLoadingState(list: []));
  Stream<TvShowsState> get stateStream => _stateController.stream;
  TvShowsState get state => _stateController.value;

  final _searchDebouncer = Debouncer(Durations.searchDebbounce);
  String _lastSearchId = '';

  void dispose() {
    _stateController.close();
  }

  Future<void> fetchTvSeries() async {
    _stateController.add(
      TvShowsLoadingState(list: state.list),
    );

    _lastSearchId = const Uuid().v4().toString();
    final currentSearchId = _lastSearchId;

    try {
      final apiList = await _seriesApi.getShows();

      if (_lastSearchId == currentSearchId) {
        _stateController.add(
          TvShowsSuccessState(
            list: apiList.map((e) => TvShow.fromApi(e)).toList(),
          ),
        );
      }
    } catch (e) {
      // Handle error.
      if (_lastSearchId == currentSearchId) {
        _stateController.add(const TvShowsErrorState());
      }
    }
  }

  Future<void> search(String value) async {
    _searchDebouncer.run(() async {
      if (value.trim().isEmpty) {
        fetchTvSeries();
        return;
      }

      _stateController.add(
        TvShowsLoadingState(list: state.list),
      );

      // _lastSearchId can be changed by the next call, invalidating this one.
      _lastSearchId = const Uuid().v4().toString();
      final currentSearchId = _lastSearchId;
      try {
        final apiList = await _seriesApi.searchShows(value);

        if (_lastSearchId == currentSearchId) {
          _stateController.add(
            TvShowsSuccessState(
              list: apiList.map((e) => TvShow.fromApi(e)).toList(),
            ),
          );
        }
      } catch (e) {
        if (_lastSearchId == currentSearchId) {
          _stateController.add(const TvShowsErrorState());
        }
      }
    });
  }
}
