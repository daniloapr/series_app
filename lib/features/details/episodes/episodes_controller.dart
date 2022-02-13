import 'package:meta/meta.dart';
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

  List<Episode> _episodes = [];
  int _seasonLength = 0;

  final _seriesApi = locator<SeriesApi>();

  void dispose() {
    _stateController.close();
  }

  void fetchEpisodes(String showId) async {
    _stateController.add(EpisodesLoadingState());

    try {
      final apiList = await _seriesApi.getEpisodes(showId);
      _episodes = apiList.map(Episode.fromApi).toList();
      _seasonLength = getSeasonLength(_episodes);

      _stateController.add(
        EpisodesSuccessState(
          selectedSeason: 1,
          seasonLength: _seasonLength,
          list: _episodes.where((episode) => episode.season == 1).toList(),
        ),
      );
    } catch (e) {
      _stateController.add(EpisodesErrorState());
    }
  }

  void changeSeason(int season) {
    _stateController.add(
      EpisodesSuccessState(
        selectedSeason: season,
        seasonLength: _seasonLength,
        list: _episodes.where((episode) => episode.season == season).toList(),
      ),
    );
  }

  @visibleForTesting
  static int getSeasonLength(List<Episode> episodes) {
    return episodes.map((e) => e.season).toSet().length;
  }
}
