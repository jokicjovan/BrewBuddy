import 'package:BrewBuddy/pages/CouponPage.dart';
import 'package:BrewBuddy/pages/DashboardPage.dart';
import 'package:BrewBuddy/pages/SearchPage.dart';
import 'package:BrewBuddy/pages/PopularPage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const DashboardPage(),
    const SearchPage(),
    const PopularPage(),
    const CouponPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs.map((Widget tab) {
          return Navigator(
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                builder: (context) => tab,
              );
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => showDialog<String>(
            context: context,

            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            )),
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
            buildNavItem(icon: Icons.search_rounded, label: "Search", index: 1),
            const SizedBox(width: 50),
            buildNavItem(icon: Icons.local_fire_department_rounded, label: "Popular", index: 2),
            buildNavItem(icon: Icons.local_activity_rounded, label: "Coupon", index: 3),
          ],
        ),
      ),
    );
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
