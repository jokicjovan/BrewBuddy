import 'package:BrewBuddy/pages/CouponPage.dart';
import 'package:BrewBuddy/pages/DashboardPage.dart';
import 'package:BrewBuddy/pages/SearchPage.dart';
import 'package:BrewBuddy/pages/TrendingPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    DashboardPage(),
    SearchPage(),
    TrendingPage(),
    CouponPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text("BrewBuddy"),
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          centerTitle: true,
        ),
        body: _tabs[_currentIndex],
        floatingActionButton: FloatingActionButton.large(
          onPressed: () {},
          shape: const CircleBorder(),
          child: ImageIcon(
            const AssetImage('assets/beers-icon.png'),
            color: Theme.of(context).colorScheme.onPrimary,
            size: 50,
          ),
          tooltip: "Drink",
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 80,
          color: Colors.transparent,
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home_rounded,
                  color: _currentIndex == 0 ? Theme.of(context).colorScheme.onSecondary : Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.search_rounded,
                  color: _currentIndex == 1 ? Theme.of(context).colorScheme.onSecondary : Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              const SizedBox(width: 50,),
              IconButton(
                icon: Icon(
                  Icons.local_fire_department_rounded,
                  color: _currentIndex == 2 ?Theme.of(context).colorScheme.onSecondary : Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.local_activity_rounded,
                  color: _currentIndex == 3 ? Theme.of(context).colorScheme.onSecondary : Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
