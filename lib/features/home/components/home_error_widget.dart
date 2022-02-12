import 'package:flutter/material.dart';
import 'package:series_app/constants/strings.dart';

class HomeErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const HomeErrorWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(Strings.somethingWrong),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(Strings.tryAgainBtn.toUpperCase()),
        ),
      ],
    );
  }
}
