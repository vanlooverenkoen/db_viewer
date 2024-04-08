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
          titleLarge: TextStyle(color: Colors.black),
          bodyLarge: TextStyle(color: Colors.black),
          titleSmall: TextStyle(color: Colors.black),
          labelLarge: TextStyle(color: Colors.black),
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
          titleLarge: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
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
