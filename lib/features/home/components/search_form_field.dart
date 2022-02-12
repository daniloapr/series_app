import 'package:flutter/material.dart';
import 'package:series_app/constants/constants.dart';

class SearchFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchFormField({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontalPadding),
      child: TextFormField(
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
    );
  }
}
