import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/pages/CouponAdministratorPage.dart';
import 'package:BrewBuddy/pages/CouponPage.dart';
import 'package:BrewBuddy/pages/DashboardPage.dart';
import 'package:BrewBuddy/pages/SearchPage.dart';
import 'package:BrewBuddy/pages/PopularPage.dart';
import 'package:BrewBuddy/widgets/dialogs/DrinkDialog.dart';
import 'package:BrewBuddy/widgets/dialogs/RateDialog.dart';
import 'package:BrewBuddy/services/AuthService.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String role = "user";
  AuthService authService = AuthService();
  int _currentIndex = 0;

  getRole() async {
    final role = await authService.getRole();
    if (mounted) {
      setState(() {
        this.role = role;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const DashboardPage(
                ),
              );
            },
          ),
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const SearchPage(
                ),
              );
            },
          ),
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const PopularPage(
                ),
              );
            },
          ),
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => (role == "user" ? const CouponPage() : const CouponAdministratorPage()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: DrinkDialog(
              onDrinkPressed: (selectedBeer, isBeerRated) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Drink logged successfully'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                if (!isBeerRated) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: RateDialog(
                        selectedBeer: selectedBeer,
                        onRatePressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Drink rated successfully'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        shape: const CircleBorder(),
        tooltip: "Drink",
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        child: ImageIcon(
          const AssetImage('lib/assets/beers-icon.png'),
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
            buildNavItem(
                icon: Icons.local_fire_department_rounded,
                label: "Popular",
                index: 2),
            buildNavItem(
                icon: Icons.local_activity_rounded, label: "Coupon", index: 3),
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
