import 'package:BrewBuddy/services/BeerService.dart';
import 'package:BrewBuddy/services/FestivalService.dart';
import 'package:BrewBuddy/widgets/BeerCard.dart';
import 'package:BrewBuddy/widgets/BreweryCard.dart';
import 'package:BrewBuddy/widgets/DrunkWarningCard.dart';
import 'package:BrewBuddy/widgets/FestivalCard.dart';
import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/Festival.dart';
import 'package:BrewBuddy/pages/ItemListPage.dart';
import 'package:BrewBuddy/services/BreweryService.dart';
import 'package:BrewBuddy/services/ImageService.dart';
import 'package:BrewBuddy/services/UserService.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  UserService userService = UserService();
  BreweryService breweryService = BreweryService();
  ImageService imageService = ImageService();
  BeerService beerService = BeerService();
  FestivalService festivalService = FestivalService();
  List<Beer> beers = [];
  List<Brewery> breweries = [];
  List<Festival> festivals = [];
  bool isUserDrunk = false;

  Future<void> getBeers() async {
    List<Beer> beers = await userService.getBeerRecommendation();
    if (beers.isEmpty){
      beers=await beerService.getPopularBeers();
    }
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
    if (mounted) {
      setState(() {
        isUserDrunk = isDrunk;
      });
    }
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
    List<Festival> festivals = await userService.getFestivalRecommendation();
    if (festivals.isEmpty){
      festivals=await festivalService.getFestivals();
    }
    if (mounted) {
      setState(() {
        this.festivals = festivals;
      });
    }
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
    getFestivals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 64.0),
        child: Column(
          children: [
            isUserDrunk
                ? const DrunkWarningCard()
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
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        "See more...",
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          fontSize: 16,
                        ),
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
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        "See more...",
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          fontSize: 16,
                        ),
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
                      return FestivalCard(festivals: festivals, index: index);
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

}
