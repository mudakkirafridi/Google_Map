import 'package:flutter/material.dart';
import 'package:map_toturial/screens/conver_cordinates_address.dart';
import 'package:map_toturial/screens/current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const CurrentLocation(),
    );
  }
}
