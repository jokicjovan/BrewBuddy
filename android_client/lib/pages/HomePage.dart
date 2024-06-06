import 'package:BrewBuddy/pages/CouponAdministratorPage.dart';
import 'package:BrewBuddy/pages/CouponPage.dart';
import 'package:BrewBuddy/pages/DashboardPage.dart';
import 'package:BrewBuddy/pages/SearchPage.dart';
import 'package:BrewBuddy/pages/PopularPage.dart';
import 'package:BrewBuddy/widgets/dialogs/DrinkDialog.dart';
import 'package:BrewBuddy/widgets/dialogs/RateDialog.dart';
import 'package:BrewBuddy/services/AuthService.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  String role = "user";
  int _currentIndex = 0;
  bool isLogout = true;

  final GlobalKey<DashboardPageState> _dashboardKey = GlobalKey<DashboardPageState>();
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("BrewBuddy"),
        titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _onBack();
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Navigator(
            key: _navigatorKeys[0],
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => DashboardPage(key: _dashboardKey,),
            ),
          ),
          Navigator(
            key: _navigatorKeys[1],
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const SearchPage(),
            ),
          ),
          Container(),
          Navigator(
            key: _navigatorKeys[3],
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const PopularPage(),
            ),

          ),
          Navigator(
            key: _navigatorKeys[4],
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => (role == "user"
                  ? const CouponPage()
                  : const CouponAdministratorPage()),
            ),
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
                _dashboardKey.currentState?.fetchData();
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
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle:
            TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        selectedItemColor: Theme.of(context).colorScheme.onSecondary,
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              color: _currentIndex == 0
                  ? Theme.of(context).colorScheme.onSecondary
                  : Colors.white,
              size: 35,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
              color: _currentIndex == 1
                  ? Theme.of(context).colorScheme.onSecondary
                  : Colors.white,
              size: 35,
            ),
            label: "Search",
          ),
          const BottomNavigationBarItem(
            icon: SizedBox.shrink(), // Transparent item to fill space
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_fire_department_rounded,
              color: _currentIndex == 3
                  ? Theme.of(context).colorScheme.onSecondary
                  : Colors.white,
              size: 35,
            ),
            label: "Popular",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_activity_rounded,
              color: _currentIndex == 4
                  ? Theme.of(context).colorScheme.onSecondary
                  : Colors.white,
              size: 35,
            ),
            label: "Coupon",
          ),
        ],
      ),
    );
  }

  Future<void> _onBack() async {
    final navigator = _navigatorKeys[_currentIndex].currentState;
    if (navigator == null) {
      return;
    }

    if (navigator.canPop()) {
      navigator.pop();
    } else {
      final shouldLogout = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout'),
            ),
          ],
        ),
      );

      if (shouldLogout == true) {
        authService.logout();
        Navigator.of(context).pushNamed('/login');
      }
    }
  }

  void _onTap(int val) {
    if (_currentIndex != val) {
      setState(() {
        _currentIndex = val;
      });
    } else {
      final navigator = _navigatorKeys[_currentIndex].currentState;
      if (navigator != null) {
        navigator.popUntil((route) => route.isFirst);
      }
    }
  }
}
