import 'package:flutter/material.dart';
import 'package:series_app/assets/images/images.dart';
import 'package:series_app/constants/strings.dart';

class HomeEmpty extends StatelessWidget {
  const HomeEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.logo, width: 100),
          const SizedBox(height: 20),
          const Text(Strings.emptySearch),
        ],
      ),
    );
  }
}
