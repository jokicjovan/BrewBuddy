import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/pages/CouponPage.dart';
import 'package:BrewBuddy/pages/DashboardPage.dart';
import 'package:BrewBuddy/pages/SearchPage.dart';
import 'package:BrewBuddy/pages/PopularPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
      resizeToAvoidBottomInset: false,
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
              child: buildDrinkDialog(context),
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

  Padding buildDrinkDialog(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height:150 ,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownSearch<Beer>(

                        popupProps: const PopupProps.dialog(
                          showSearchBox: true,
                        ),
                        asyncItems: (String filter) => Future.value(Beer.getBeers()).then((beers) =>
                          beers.where((beer) => beer.name.contains(filter)).toList()),
                        itemAsString: (Beer u) => u.name,
                        onChanged: (Beer? data) => print(data?.name),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Select Beer",
                            hintText: "Select beer to log",
                          ),
                        ),

                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                      showDialog<String>(
                          context: context,

                          builder: (BuildContext context) => Dialog(
                            child: buildRateDialog(context),
                          ));
                    },
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.onSecondary, // Set background color here
                      )
                      , child: const Text(
                      "Drink!",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),)
                  ],
                ),
              ),
            );
  }
  Padding buildRateDialog(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height:250 ,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ),

                    const TextField(
                      maxLines: 3, // Makes the TextField a text area
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your text here',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    },
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.onSecondary, // Set background color here
                      )
                      , child: const Text(
                        "Rate",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),),
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
