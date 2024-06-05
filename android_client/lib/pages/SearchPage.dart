import 'dart:typed_data';

import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:BrewBuddy/services/BeerService.dart';
import 'package:BrewBuddy/services/BreweryService.dart';
import 'package:BrewBuddy/services/ImageService.dart';
import 'package:BrewBuddy/widgets/BeerCard.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  BeerService beerService=BeerService();
  BreweryService breweryService=BreweryService();
  ImageService imageService=ImageService();

  List<Beer> beers = [];
  List<Brewery> breweries = [];
  List<String> types = [];
  List<String> alcoholLevels = [];
  List<String> beerTypes = [];


  Brewery? selectedBrewery;
  String? selectedType="";
  String? selectedLevel="";

  List<Beer> filteredBeers = [];
  String query = '';
  final TextEditingController _controller = TextEditingController();
  bool showFilters = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {

    final beers =await beerService.filterBeers(type:this.selectedType??"",alcohol:this.selectedLevel??"",breweryId: this.selectedBrewery?.id.toString()??"");
    for (int i = 0; i < beers.length; i++) {
      final Uint8List img = await imageService.getBeerImage(beers[i].imageName);
      beers[i].image = img;
    }
    final breweries = await breweryService.getBreweries();
    final beerTypes = await beerService.getBeerTypes();
    if (mounted) {
      setState(() {
        this.beers = beers;
        this.breweries = breweries;
        types = beerTypes;
        alcoholLevels = ["LOW", "HIGH"];

        filteredBeers = beers;
      });
    }
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      query = newQuery;
      filteredBeers = beers
          .where(
              (beer) => beer.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void clearSearchQuery() {
    setState(() {
      query = '';
      _controller.clear();
      filteredBeers = beers;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search for a beer',
                hintText: 'Type the beer name',
                border: const OutlineInputBorder(),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: clearSearchQuery,
                      )
                    : null,
              ),
              onChanged: updateSearchQuery,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showFilters = !showFilters;
              });
            },
            child: Text(showFilters ? 'Hide Filters' : 'Show Filters'),
          ),
          if (showFilters)
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownSearch<Brewery>(
                      clearButtonProps: const ClearButtonProps(isVisible: true),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: const TextFieldProps(
                          decoration: InputDecoration(
                            labelText: 'Search for a brewery',
                            hintText: 'Type the brewery name',
                          ),
                        ),
                        itemBuilder: (context, brewery, isSelected) {
                          return ListTile(
                            title: Text(brewery.name),
                          );
                        },

                      ),
                      selectedItem: this.selectedBrewery,
                      asyncItems: (String filter) => Future.value(breweries)
                          .then((breweries) => breweries
                              .where((brewery) => brewery.name.contains(filter))
                              .toList()),
                      itemAsString: (Brewery b) => b.name,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Select a brewery",
                        ),
                      ),
                      onChanged: (Brewery? selectedBrewery) {
                        setState(() {
                          this.selectedBrewery = selectedBrewery;
                          fetchData();
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownSearch<String>(
                      clearButtonProps: const ClearButtonProps(isVisible: true),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: const TextFieldProps(
                          decoration: InputDecoration(
                            labelText: 'Search for a type',
                            hintText: 'Type the beer type',
                          ),
                        ),
                        itemBuilder: (context, item, isSelected) {
                          return ListTile(
                            title: Text(item),
                          );
                        },
                      ),
                      selectedItem: this.selectedType!=""?this.selectedType:null,
                      asyncItems: (String filter) => Future.value(types).then(
                          (types) => types
                              .where((type) => type.contains(filter))
                              .toList()),
                      itemAsString: (String t) => t,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Select a type",
                        ),
                      ),
                      onChanged: (String? selectedType) {
                        setState(() {
                          this.selectedType = selectedType;
                          fetchData();
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownSearch<String>(
                      clearButtonProps: const ClearButtonProps(isVisible: true),
                      popupProps: PopupProps.dialog(
                        showSearchBox: true,
                        searchFieldProps: const TextFieldProps(
                          decoration: InputDecoration(
                            labelText: 'Search for an alcohol level',
                            hintText: 'Type the alcohol level',
                          ),
                        ),
                        itemBuilder: (context, item, isSelected) {
                          return ListTile(
                            title: Text(item),
                          );
                        },

                      ),
                      selectedItem: this.selectedLevel!=""?this.selectedLevel:null,
                      asyncItems: (String filter) => Future.value(alcoholLevels)
                          .then((levels) => levels
                              .where((level) => level.contains(filter))
                              .toList()),
                      itemAsString: (String t) => t,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Select an alcohol level",
                        ),
                      ),
                      onChanged: (String? selectedLevel) {
                        setState(() {
                          this.selectedLevel = selectedLevel;
                          fetchData();
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          Expanded(
              child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.681,
            ),
            itemCount: filteredBeers.length,
            itemBuilder: (context, index) {
              return BeerCard(beer: beers[index]);
            },
          )),
        ],
      ),
    );
  }

}
