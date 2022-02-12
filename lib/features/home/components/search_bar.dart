import 'package:flutter/material.dart';
import 'package:series_app/constants/strings.dart';

class SearchFormField extends StatelessWidget {
  const SearchFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: Strings.searchHint,
      ),
    );
  }
}
