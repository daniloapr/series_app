import 'package:flutter/material.dart';
import 'package:series_app/components/error_view.dart';
import 'package:series_app/constants/colors.dart';
import 'package:series_app/constants/strings.dart';
import 'package:series_app/features/home/components/home_empty.dart';
// import 'package:series_app/components/error_widget.dart';
import 'package:series_app/features/home/components/home_title.dart';
import 'package:series_app/features/home/components/search_form_field.dart';
import 'package:series_app/features/home/components/tv_shows_list.dart';
import 'package:series_app/features/home/controllers/tv_shows_controller.dart';
import 'package:series_app/features/home/controllers/tv_shows_state.dart';
import 'package:series_app/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _tvShowsController = locator<TvShowsController>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tvShowsController.fetchTvSeries();
  }

  @override
  void dispose() {
    super.dispose();
    _tvShowsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const HomeTitle(),
            StreamBuilder<TvShowsState>(
                stream: _tvShowsController.stateStream,
                builder: (context, snapshot) {
                  return SearchFormField(
                    onChanged: _tvShowsController.search,
                    isLoading: snapshot.data is TvShowsLoadingState,
                  );
                }),
            Expanded(
              child: StreamBuilder<TvShowsState>(
                stream: _tvShowsController.stateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;

                  if (_scrollController.hasClients) {
                    _scrollController.jumpTo(0);
                  }

                  if (state is TvShowsSuccessState) {
                    if (state.list.isNotEmpty) {
                      return TvShowsList(
                        list: state.list,
                        scrollController: _scrollController,
                      );
                    }

                    return const HomeEmpty();
                  } else if (state is TvShowsErrorState) {
                    return ErrorView(
                      errorText: Strings.somethingWrong,
                      onPressed: _tvShowsController.fetchTvSeries,
                    );
                  } else if (state is TvShowsLoadingState) {
                    if (state.list.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      return TvShowsList(
                        list: state.list,
                        scrollController: _scrollController,
                      );
                    }
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
