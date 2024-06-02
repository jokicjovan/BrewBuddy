import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/models/Festival.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'BeerPage.dart';

class ItemListPage extends StatefulWidget {
  final List<Widget> widgets;

  const ItemListPage({required this.widgets, Key? key}) : super(key: key);

  @override
  ItemListPageState createState() => ItemListPageState();
}

class ItemListPageState extends State<ItemListPage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    widgets = widget.widgets;
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.681,

              ),


              itemCount: widgets.length,
              itemBuilder: (context, index) {
                return widgets[index];
              },
            ),
        ),
        );
  }
}
