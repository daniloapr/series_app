import 'package:flutter/material.dart';
import 'package:series_app/constants/strings.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.keyboard_arrow_left),
      label: const Text(Strings.back),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.only(
            left: 4,
            right: 12,
            top: 16,
            bottom: 16,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black87),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
