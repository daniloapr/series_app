import 'package:flutter/material.dart';

class HomeErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const HomeErrorWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Ops.. Something wrong'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onPressed,
          child: Text('Try again'.toUpperCase()),
        ),
      ],
    );
  }
}
