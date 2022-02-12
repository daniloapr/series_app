import 'package:flutter/material.dart';
import 'package:series_app/constants/strings.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

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
