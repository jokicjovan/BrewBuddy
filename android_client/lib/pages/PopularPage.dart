import 'dart:typed_data';
import 'package:BrewBuddy/pages/BeerTypeListPage.dart';
import 'package:BrewBuddy/services/AuthService.dart';
import 'package:BrewBuddy/services/UserService.dart';
import 'package:flutter/material.dart';

import 'BeerPage.dart';
import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/pages/BreweryPage.dart';
import 'package:BrewBuddy/pages/ItemListPage.dart';
import 'package:BrewBuddy/services/BeerService.dart';
import 'package:BrewBuddy/services/BreweryService.dart';
import 'package:BrewBuddy/services/ImageService.dart';


class PopularPage extends StatefulWidget {
  const PopularPage({super.key});

  @override
  PopularPageState createState() => PopularPageState();
}

class PopularPageState extends State<PopularPage> {
  BeerService beerService=BeerService();
  BreweryService breweryService=BreweryService();
  ImageService imageService=ImageService();
  AuthService authService=AuthService();
  UserService userService=UserService();
  List<Beer> beers = [];
  List<Brewery> breweries = [];
  List<String> beerTypes = [];
  List<String> users = [];
  String role="user";

  getRole() async {
    final role = await authService.getRole();
    if (mounted) {
      setState(() {
        this.role = role;
      });
    }
  }

  Future<void> getBeers() async {
    final beers = await beerService.getPopularBeers();
    for (int i = 0; i < beers.length; i++) {
      final Uint8List img = await imageService.getBeerImage(beers[i].imageName);
      beers[i].image = img;
    }
    if(mounted) {
      setState(() {
        this.beers = beers;
      });
    }
  }
  Future<void> getBreweries() async {
    final breweries = await breweryService.getPopularBreweries();
    for (int i = 0; i < breweries.length; i++) {
      final img = await imageService.getBreweryImage(breweries[i].imageName);
      breweries[i].image = img;
    }
    if (mounted) {
      setState(() {
        this.breweries = breweries;
      });
    }
  }
  Future<void> getBeerTypes() async {
    final beerTypes = await beerService.getPopularBeerTypes();
    if (mounted) {
      setState(() {
        this.beerTypes = beerTypes;
      });
    }
  }

  Future<void> getUsers() async {
    final users = await userService.getPopularUsers();
    if (mounted) {
      setState(() {
        this.users = users;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getBeers();
    getBreweries();
    getBeerTypes();
    getRole();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 64.0),
        child: Column(
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 30),
                const Expanded(
                    child: Text(
                  "Beers",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ItemListPage(
                            widgets: List.generate(beers.length,
                                    (index) => buildBeerCard(index, context)),
                          )));
                    },
                    child: const Text(
                      "See more...",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 220,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return buildBeerCard(index, context);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 25,
                ),
                itemCount: beers.length < 10 ? beers.length : 10,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 30),
                const Expanded(
                    child: Text(
                  "Breweries",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ItemListPage(
                              widgets: List.generate(
                                breweries.length,
                                    (index) =>
                                    buildBreweryCard(index, context),
                              ))));
                    },
                    child: const Text(
                      "See more...",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 220,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return buildBreweryCard(index, context);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 25,
                ),
                itemCount: breweries.length > 10 ? 10 : breweries.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 30),
                Expanded(
                    child: Text(
                  "Beer Types",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
              shrinkWrap: true,
              // Makes the ListView take only the necessary height
              physics: const NeverScrollableScrollPhysics(),
              // Disables scrolling of this ListView
              itemBuilder: (context, index) {
                return buildBeerTypeCard(index, context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              itemCount: beerTypes.length,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(left: 20, right: 20),
            ),

            role=="admin"?Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 30),
                    Expanded(
                        child: Text(
                          "Users",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  // Makes the ListView take only the necessary height
                  physics: const NeverScrollableScrollPhysics(),
                  // Disables scrolling of this ListView
                  itemBuilder: (context, index) {
                    return buildUserCard(index, context);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemCount: users.length,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                ),
              ],
            ):Container(),
          ],
        ),
      )),
    );
  }

  GestureDetector buildBeerCard(int index, BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BeerPage(
                    beerId: beers[index].id,
                  )));
        },
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(151, 151, 151, 0.22),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              beers[index].image != null
                  ? Image.memory(
                beers[index].image ?? Uint8List(0),
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              )
                  : const Text("Missing Image"),
              Text(
                beers[index].name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 22,
                ),
              ),
              index < 3
                  ? Image.asset(
                      index == 0
                          ? "lib/assets/gold-medal.png"
                          : index == 1
                              ? "lib/assets/silver-medal.png"
                              : "lib/assets/bronze-medal.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    )
                  : SizedBox(
                      height: 50,
                      child: Text(
                        "${index + 1}.",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }

  GestureDetector buildBreweryCard(int index, BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BreweryPage(
                    breweryId: breweries[index].id,
                  )));
        },
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(151, 151, 151, 0.22),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              breweries[index].image != null
                  ? Image.memory(
                breweries[index].image ?? Uint8List(0),
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              )
                  : const Text("Missing Image"),
              Text(
                breweries[index].name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 22,
                ),
              ),
              index < 3
                  ? Image.asset(
                      index == 0
                          ? "lib/assets/gold-medal.png"
                          : index == 1
                              ? "lib/assets/silver-medal.png"
                              : "lib/assets/bronze-medal.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    )
                  : SizedBox(
                      height: 50,
                      child: Text(
                        "${index + 1}.",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    )
            ],
          ),
        ));
  }

  GestureDetector buildBeerTypeCard(int index, BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BeerTypeListPage(
                    beerType: beerTypes[index],
                  )));
        },
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(151, 151, 151, 0.22),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Row(
                  children: [
                    index < 3
                        ? Image.asset(
                            index == 0
                                ? "lib/assets/gold-medal.png"
                                : index == 1
                                    ? "lib/assets/silver-medal.png"
                                    : "lib/assets/bronze-medal.png",
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          )
                        : SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: Text(
                                "${index + 1}.",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          beerTypes[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 22,
                          ),
                        ),

                      ],
                    )),

                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Container buildUserCard(int index, BuildContext context) {
    return Container(
          width: 150,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(151, 151, 151, 0.22),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Row(
                  children: [
                    index < 3
                        ? Image.asset(
                      index == 0
                          ? "lib/assets/gold-medal.png"
                          : index == 1
                          ? "lib/assets/silver-medal.png"
                          : "lib/assets/bronze-medal.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    )
                        : SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: Text(
                          "${index + 1}.",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              users[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSecondary,
                                fontSize: 22,
                              ),
                            ),

                          ],
                        )),

                  ],
                ),
              ),
            ],
          ),
        );
  }
}
