import 'package:BrewBuddy/pages/LoginPage.dart';
import 'package:BrewBuddy/pages/HomePage.dart';
import 'package:BrewBuddy/services/AuthService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthService _authService = AuthService();

  Future<Widget> _getInitialScreen() async {
    if (await _authService.isTokenValid()) {
      return const MainPage();
    }
    return const LoginPage();
  }

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
        cardColor: const Color.fromRGBO(33, 33, 33, 1.0),
        useMaterial3: true,
      ),
      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }
}
