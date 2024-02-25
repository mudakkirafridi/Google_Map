import 'package:flutter/material.dart';
import 'package:map_toturial/screens/current_location.dart';
import 'package:map_toturial/screens/custom_info_window.dart';
import 'package:map_toturial/screens/cutom_marker_screen.dart';
import 'package:map_toturial/screens/example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            shadowColor: Colors.black,
            elevation: 9,
          )),
      debugShowCheckedModeBanner: false,
      home: MyInfoWindow(),
    );
  }
}
