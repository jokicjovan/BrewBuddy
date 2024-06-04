import 'dart:typed_data';

import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/pages/BreweryPage.dart';
import 'package:flutter/material.dart';



class BreweryCard extends StatelessWidget {
  final Brewery brewery;

  const BreweryCard({
    super.key,
    required this.brewery
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BreweryPage(
                breweryId: brewery.id,
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
              brewery.image != null
                  ? Image.memory(
                brewery.image ?? Uint8List(0),
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              )
                  : const Text("Missing Image"),
              Column(
                children: [
                  Text(
                    brewery.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 22,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        brewery.city.name.length > 13
                            ? "${brewery.city.name.substring(0, 10)}..."
                            : brewery.city.name,
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
            ],
          ),
        ));
  }
}