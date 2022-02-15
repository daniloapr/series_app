import 'package:flutter/material.dart';

class UIWrapper {
  const UIWrapper._();
  static const width = 375.0;
  static const height = 667.0;

  static Widget wrap(Widget child) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: const MediaQueryData(size: Size(width, height)),
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          home: child,
        ),
      ),
    );
  }
}
