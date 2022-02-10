import 'package:flutter/material.dart';
import 'package:series_app/features/home/home_controller.dart';
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
      appBar: AppBar(
        title: const Text('Series app'),
      ),
      body: Container(),
    );
  }
}
