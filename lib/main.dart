import 'package:flutter/material.dart';
import 'package:fbteste/splash/splash_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_page/home_page_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fbteste',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashWidget(),
    );
  }
}
