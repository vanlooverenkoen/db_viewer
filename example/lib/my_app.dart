import 'package:flutter/material.dart';
import 'package:moor_db_viewer_example/ui/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        accentColor: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}
