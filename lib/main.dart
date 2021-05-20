import 'package:flutter/material.dart';
import 'package:nallagram/nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Nav(),
    );
  }
}
