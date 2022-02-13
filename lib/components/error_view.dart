import 'package:flutter/material.dart';
import 'package:series_app/constants/strings.dart';

class ErrorView extends StatelessWidget {
  final VoidCallback onPressed;
  final String errorText;
  const ErrorView({
    Key? key,
    required this.errorText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(errorText),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(Strings.tryAgainBtn.toUpperCase()),
        ),
      ],
    );
  }
}
