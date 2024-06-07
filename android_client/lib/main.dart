import 'package:flutter/material.dart';
import 'package:BrewBuddy/pages/LoginPage.dart';
import 'package:BrewBuddy/pages/HomePage.dart';
import 'package:BrewBuddy/services/AuthService.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService authService = AuthService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrewBuddy',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
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
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
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

  Future<Widget> _getInitialScreen() async {
    if (await authService.isTokenValid()) {
      return const HomePage();
    }
    return const LoginPage();
  }
}
