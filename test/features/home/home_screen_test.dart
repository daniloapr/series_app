import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';
import 'package:series_app/components/error_view.dart';
import 'package:series_app/features/home/components/search_form_field.dart';
import 'package:series_app/features/home/components/tv_shows_list.dart';
import 'package:series_app/features/home/controllers/tv_shows_controller.dart';
import 'package:series_app/features/home/controllers/tv_shows_state.dart';
import 'package:series_app/features/home/home_screen.dart';
import 'package:series_app/models/tv_show.dart';
import '../../ui_wrapper.dart';
import 'controllers/tv_shows_controller_mock.dart';

const mockTvShow = TvShow(id: 'id', name: 'name');
void main() {
  final tvShowsController = TvShowsControllerMock();
  final tvShowsStreamController =
      BehaviorSubject<TvShowsState>.seeded(const TvShowsLoadingState(list: []));

  setUpAll(() {
    GetIt.I.registerFactory<TvShowsController>(() => tvShowsController);
    when(
      () => tvShowsController.stateStream,
    ).thenAnswer((invocation) => tvShowsStreamController.stream);

    when(
      () => tvShowsController.fetchTvSeries(),
    ).thenAnswer((invocation) async {});

    when(
      () => tvShowsController.search(any()),
    ).thenAnswer((invocation) async {});
  });

  group('HomeScreen', () {
    testWidgets('renders properly', (WidgetTester tester) async {
      await tester.pumpWidget(UIWrapper.wrap(const HomeScreen()));
      await tester.pump();

      expect(find.byType(SearchFormField), findsOneWidget);
      expect(find.byKey(const Key('HomeLoading')), findsOneWidget);

      tvShowsStreamController.add(
        const TvShowsSuccessState(list: [mockTvShow]),
      );
      await tester.pump();

      expect(find.byType(TvShowsList), findsOneWidget);
      final tvShowsList = tester.widget<TvShowsList>(find.byType(TvShowsList));
      expect(tvShowsList.list, [mockTvShow]);

      tvShowsStreamController.add(
        const TvShowsErrorState(),
      );
      await tester.pump();

      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('calls search properly', (WidgetTester tester) async {
      await tester.pumpWidget(UIWrapper.wrap(const HomeScreen()));
      await tester.pump();

      await tester.enterText(find.byType(SearchFormField), 'Spider Man');
      await tester.pump();

      verify(() => tvShowsController.search('Spider Man')).called(1);
    });
  });
}
