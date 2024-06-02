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
          tooltip: "Drink",
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          child: ImageIcon(
            const AssetImage('assets/beers-icon.png'),
            color: Theme.of(context).colorScheme.onPrimary,
            size: 50,
          ),
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
            children: [
              buildNavItem(icon: Icons.home_rounded, label: "Home", index: 0),
              buildNavItem(
                  icon: Icons.search_rounded, label: "Search", index: 1),
              const SizedBox(
                width: 50,
              ),
              buildNavItem(
                  icon: Icons.local_fire_department_rounded,
                  label: "Popular",
                  index: 2),
              buildNavItem(
                  icon: Icons.local_activity_rounded,
                  label: "Coupon",
                  index: 3),
            ],
          ),
        ));
  }

  Widget buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _currentIndex == index
                ? Theme.of(context).colorScheme.onSecondary
                : Colors.white,
            size: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              label,
              style: TextStyle(
                color: _currentIndex == index
                    ? Theme.of(context).colorScheme.onSecondary
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
