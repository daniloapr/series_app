import 'package:flutter/material.dart';
import 'package:series_app/constants/colors.dart';
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
            left: 8,
            right: 18,
            top: 12,
            bottom: 12,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(AppColors.white),
        foregroundColor: MaterialStateProperty.all(AppColors.black),
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
