import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/Beer.dart';
import '../pages/BeerPage.dart';

class BeerCard extends StatelessWidget {
  final Beer beer;


  const BeerCard({
    super.key,
    required this.beer
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BeerPage(
                beerId: beer.id,
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
              beer.image != null
                  ? Image.memory(
                beer.image ?? Uint8List(0),
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              )
                  : const Text("Missing Image"),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        beer.type,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${beer.percentageOfAlcohol}%",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    beer.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 22,
                    ),
                  ),
                  const Text(
                    "Powered By",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    beer.brewery.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}