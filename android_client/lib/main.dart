import 'package:BrewBuddy/pages/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrewBuddy',

      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          onPrimary: const Color.fromRGBO(245, 195, 0, 1.0),
          onSecondary: const Color.fromRGBO(1, 1, 1, 1.0),


          // ···
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Home'),
    );
  }
}