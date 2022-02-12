import 'package:flutter/material.dart';
import 'package:series_app/constants/colors.dart';
import 'package:series_app/features/home/components/home_error_widget.dart';
import 'package:series_app/features/home/components/search_bar.dart';
import 'package:series_app/features/home/components/tv_shows_list.dart';
import 'package:series_app/features/home/home_controller.dart';
import 'package:series_app/features/home/home_state.dart';
import 'package:series_app/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = locator<HomeController>();

  @override
  void initState() {
    super.initState();
    _controller.fetchTvSeries();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SearchBar(),
            Expanded(
              child: StreamBuilder<HomeState>(
                stream: _controller.stateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;

                  if (state is HomeSuccessState) {
                    return TvShowsList(list: state.list);
                  } else if (state is HomeErrorState) {
                    return HomeErrorWidget(
                      onPressed: _controller.fetchTvSeries,
                    );
                  } else if (state is HomeLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
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
