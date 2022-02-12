import 'package:flutter/material.dart';
import 'package:series_app/assets/images/images.dart';
import 'package:series_app/constants/constants.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: Dimens.horizontalPadding,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              Images.logo32Px,
            ),
            const SizedBox(width: 16),
            Text(
              Strings.appName.toUpperCase(),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
