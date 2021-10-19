import 'package:flutter/material.dart';
import 'package:drift_db_viewer_example/ui/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.green,
        ),
        scaffoldBackgroundColor: Colors.white,
        dividerColor: Colors.black12,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black),
          bodyText1: TextStyle(color: Colors.black),
          subtitle2: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.black),
        ),
        dialogBackgroundColor: Color(0xFFD7D7D7),
        inputDecorationTheme: InputDecorationTheme(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.green,
        ),
        scaffoldBackgroundColor: Colors.black,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              textStyle:
                  MaterialStateProperty.all(TextStyle(color: Colors.white))),
        ),
        cardColor: Color(0xFF2F2F2F),
        dividerColor: Colors.white12,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          subtitle2: TextStyle(color: Colors.white),
          button: TextStyle(color: Colors.white),
        ),
        dialogBackgroundColor: Color(0xFF2F2F2F),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
          ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}
