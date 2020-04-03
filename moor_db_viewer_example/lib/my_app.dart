import 'package:flutter/material.dart';
import 'package:moordbviewerexample/ui/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        accentColor: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
