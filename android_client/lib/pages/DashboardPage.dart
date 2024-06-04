import 'package:BrewBuddy/widgets/BeerCard.dart';
import 'package:BrewBuddy/widgets/BreweryCard.dart';
import 'package:flutter/material.dart';
import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/Festival.dart';
import 'package:BrewBuddy/pages/BeerPage.dart';
import 'package:BrewBuddy/pages/BreweryPage.dart';
import 'package:BrewBuddy/pages/FestivalPage.dart';
import 'package:BrewBuddy/pages/ItemListPage.dart';
import 'package:BrewBuddy/services/BreweryService.dart';
import 'package:BrewBuddy/services/ImageService.dart';
import 'package:BrewBuddy/services/UserService.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  UserService userService = UserService();
  BreweryService breweryService = BreweryService();
  ImageService imageService = ImageService();
  List<Beer> beers = [];
  List<Brewery> breweries = [];
  List<Festival> festivals = [];
  bool isUserDrunk = false;

  Future<void> getBeers() async {
    final beers = await userService.getBeerRecommendation();
    for (int i = 0; i < beers.length; i++) {
      final Uint8List img = await imageService.getBeerImage(beers[i].imageName);
      beers[i].image = img;
    }

    if (mounted) {
      setState(() {
        this.beers = beers;
      });
    }
  }

  Future<void> isDrunk() async {
    final isDrunk = await userService.isUserDrunk();
    setState(() {
      this.isUserDrunk = isDrunk;
    });
  }

  Future<void> getBreweries() async {
    final breweries = await breweryService.getBreweries();
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

  Future<void> getFestivals() async {
    final festivals = await userService.getFestivalRecommendation();
    setState(() {
      this.festivals = festivals;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getBreweries();
    getBeers();
    isDrunk();
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
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 64.0),
        child: Column(
          children: [
            isUserDrunk
                ? buildWarningCard(context)
                : const SizedBox(
                    width: 0,
                  ),
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
                                    (index) => BeerCard(beer: beers[index])),
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
              child: beers.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return BeerCard(beer: beers[index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 25,
                      ),
                      itemCount: beers.length < 10 ? beers.length : 10,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                    )
                  : const SizedBox(
                      height: 220,
                      child: Text(
                        "No beers to recommend.",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
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
                                    BreweryCard(brewery: breweries[index]),
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
              child: breweries.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return BreweryCard(brewery: breweries[index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 25,
                      ),
                      itemCount: breweries.length > 10 ? 10 : breweries.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                    )
                  : const SizedBox(
                      height: 220,
                      child: Text(
                        "No breweries to recommend.",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
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
                  "You should visit",
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
            festivals.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    // Makes the ListView take only the necessary height
                    physics: const NeverScrollableScrollPhysics(),
                    // Disables scrolling of this ListView
                    itemBuilder: (context, index) {
                      return buildFestivalCard(index, context);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    itemCount: festivals.length,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                  )
                : const SizedBox(
                    height: 220,
                    child: Text(
                      "Nothing to visit.",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )),
          ],
        ),
      )),
    );
  }

  Container buildWarningCard(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(225, 131, 131, 0.38),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.warning_rounded,
            color: Colors.white,
            size: 60,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("You are probably drunk",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    Text("Consider taking a nap",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector buildFestivalCard(int index, BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FestivalPage(
                    festivalId: festivals[index].id,
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
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          festivals[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 22,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              festivals[index].city.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                    Column(
                      children: [
                        Text(festivals[index].eventDate.day.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 22,
                            )),
                        Text(
                            DateFormat.MMM().format(festivals[index].eventDate),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
