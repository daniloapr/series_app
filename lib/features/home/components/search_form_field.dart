import 'package:flutter/material.dart';
import 'package:series_app/constants/constants.dart';

class SearchFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool isLoading;

  const SearchFormField({
    Key? key,
    required this.onChanged,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontalPadding),
      child: Stack(
        children: [
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: Strings.searchHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.greyLight,
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onChanged: onChanged,
          ),
          if (isLoading) const _LoadingSuffixIcon(),
        ],
      ),
    );
  }
}

class _LoadingSuffixIcon extends StatelessWidget {
  const _LoadingSuffixIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 0,
      child: Container(
        width: 20,
        height: 20,
        color: Colors.transparent,
        margin: const EdgeInsets.only(right: 16),
        child: const FittedBox(
          fit: BoxFit.contain,
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
