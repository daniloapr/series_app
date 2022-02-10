import 'package:flutter/material.dart';
import 'package:series_app/constants/dimens.dart';
import 'package:series_app/features/home/components/app_back_button.dart';
import 'package:series_app/features/home/components/poster_image.dart';
import 'package:series_app/models/tv_show.dart';

class DetailsScreen extends StatefulWidget {
  final TvShow tvShow;
  const DetailsScreen({Key? key, required this.tvShow}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                  child: Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: AppBackButton(),
              )),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: PosterImage(
                id: widget.tvShow.id,
                imageUrl: widget.tvShow.imageUrl,
              ),
            )
          ],
        ),
      ),
    );
  }
}
