import 'package:BrewBuddy/models/Beer.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}
class SearchPageState extends State<SearchPage>{

  List<Beer> beers = [];

  void getData() {
    beers = Beer.getBeers();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return SingleChildScrollView(
        child: Column(
          children: [
            DropdownSearch<String>(
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: true,
                disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: const ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Menu mode",
                  hintText: "country in menu mode",
                ),
              ),
              onChanged: print,

            ),
          ],
        ));
  }
}
