import 'package:flutter/material.dart';

class EpisodesList extends StatelessWidget {
  const EpisodesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const Key('EpisodesList'),
      shrinkWrap: true,
      itemCount: 100,
      itemBuilder: (context, index) {
        return Card(
          child: Text('Episódio'),
        );
      },
    );
  }
}
