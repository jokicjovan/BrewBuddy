import 'package:BrewBuddy/pages/CouponPage.dart';
import 'package:BrewBuddy/pages/LoginPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrewBuddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
        colorScheme: const ColorScheme(
          primary: Color.fromRGBO(245, 195, 0, 1.0),
          onPrimary: Colors.black,
          secondary: Colors.black,
          onSecondary: Color.fromRGBO(245, 195, 0, 1.0),
          surface: Colors.black,
          onSurface: Colors.white70,
          error: Colors.red,
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
        cardColor: const Color.fromRGBO(151, 151, 151, 0.22),
        useMaterial3: true,
      ),
      home: const CouponPage(),
    );
  }
}