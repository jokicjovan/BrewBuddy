import 'dart:typed_data';
import 'dart:ui';

import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/City.dart';
import 'package:BrewBuddy/pages/BreweryPage.dart';
import 'package:BrewBuddy/services/BeerService.dart';
import 'package:BrewBuddy/services/ImageService.dart';
import 'package:BrewBuddy/widgets/BeerCard.dart';
import 'package:flutter/material.dart';


class BeerPage extends StatefulWidget {
  final int beerId;

  const BeerPage({required this.beerId, super.key});
  @override
  BeerPageState createState() => BeerPageState();
}

class BeerPageState extends State<BeerPage> {
  BeerService beerService=BeerService();
  ImageService imageService=ImageService();
  int beerId=-1;
  Beer beer=Beer(id: -1, name:"", percentageOfAlcohol:0, ibu:0, price:0, type:"", imageName:"", brewery:Brewery(id: -1, name: '', imageName: '', city: City(id: -1, name: '', postalCode: '',),));
  List<Beer> beers = [];
  void getData() async {
    final beer=await beerService.getBeer(beerId);
    Uint8List img = await imageService.getBeerImage(beer.imageName);
    beer.image = img;
    img = await imageService.getBreweryImage(beer.brewery.imageName);
    beer.brewery.image = img;

    final beers =await beerService.filterBeers(type:beer.type??"",alcohol:beer.percentageOfAlcohol<4.5?"LOW":beer.percentageOfAlcohol>7.0?"HIGH":""??"",breweryId: beer.brewery.id.toString()??"");
    for (int i = 0; i < beers.length; i++) {
      final Uint8List img = await imageService.getBeerImage(beers[i].imageName);
      beers[i].image = img;
    }
    if (mounted) {
      setState(() {
        this.beer = beer;
        this.beers = beers;
      });
    }

  }


  @override
  void initState() {
    super.initState();
    beerId=widget.beerId;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: beer.id!=-1?Column(

          children: [
            beer.image != null
                ? Image.memory(
              beer.image ?? Uint8List(0),
              height: 250,
              fit: BoxFit.cover,
            )
                : const Text("Missing Image"),

            const SizedBox(height: 25,),
            Text(
              beer.name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 35,
              ),
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BreweryPage(breweryId: beer.brewery.id,)));
                },
                child:
                SizedBox(
                  width: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          "lib/assets/brewery.png",
                          height: 120,
                          fit:BoxFit.fill),
                      Text(
                        beer.brewery.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      )
                    ],
                  ),
                )),
                const SizedBox(
                  height: 150,
                  child: VerticalDivider(
                    color: Color.fromRGBO(151, 151, 151, 0.8),
                    thickness: 1.2,
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        beer.type,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [Column(
                          children: [
                            const Text(
                              "IBU",
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                color: Colors.white,
                                fontSize: 20,
                              )),
                            Text(
                              beer.ibu.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 23,
                              )),
                          ],
                        ),
                          const SizedBox(width: 20,),
                          Column(
                            children: [
                              const Text("ALC",
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                color: Colors.white,
                                fontSize: 20,
                              ),),
                              Text("${beer.percentageOfAlcohol}%",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 23,
                              ),),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 25,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 30),
                Expanded(
                    child: Text(
                  "Similar Beers",
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
            SizedBox(
              height: 220,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return BeerCard(beer: beers[index]);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 25,
                ),
                itemCount: beers.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 20),
              ),
            ),
          ],
        )
        : SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )));
  }

}
