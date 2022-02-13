import 'package:rxdart/rxdart.dart';
import 'package:series_app/data/series_api/series_api.dart';
import 'package:series_app/features/details/episodes/episodes_state.dart';
import 'package:series_app/models/episode.dart';
import 'package:series_app/service_locator.dart';

class EpisodesController {
  final _stateController =
      BehaviorSubject<EpisodesState>.seeded(EpisodesLoadingState());
  Stream<EpisodesState> get stateStream => _stateController.stream;
  EpisodesState get state => _stateController.value;

  final _seriesApi = locator<SeriesApi>();

  void dispose() {
    _stateController.close();
  }

  void fetchEpisodes(String showId) async {
    _stateController.add(EpisodesLoadingState());

    try {
      final apiList = await _seriesApi.getEpisodes(showId);

      _stateController.add(
        EpisodesSuccessState(list: apiList.map(Episode.fromApi).toList()),
      );
    } catch (e) {
      _stateController.add(EpisodesErrorState());
    }
  }
}
