import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Beer> beers = [];
  List<Brewery> breweries = [];
  List<String> types = [];
  List<String> alcoholLevels = [];
  Beer? selectedBeer;
  Brewery? selectedBrewery;
  String? selectedType;
  String? selectedLevel;

  @override
  void initState() {
    super.initState();
    festchData();
  }

  void festchData() {
    setState(() {
      beers = Beer.getBeers();
      breweries = Brewery.getBreweries();
      types = ["IPA", "PILSNER"];
      alcoholLevels = ["LOW", "HIGH"];
    });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: DropdownSearch<Beer>(
                clearButtonProps: const ClearButtonProps(isVisible: true),
                asyncItems: (String filter) => Future.value(beers).then((beers) =>
                    beers.where((beer) => beer.name.contains(filter)).toList()),
                itemAsString: (Beer u) => u.name,
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: const TextFieldProps(
                    decoration: InputDecoration(
                      labelText: 'Search for a beer',
                      hintText: 'Type the beer name',
                    ),
                  ),
                  itemBuilder: (context, beer, isSelected) {
                    return ListTile(
                      title: Text(beer.name),
                    );
                  },
                ),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Search a beer",
                  ),
                ),
                onChanged: (Beer? selectedBeer) {
                  setState(() {
                    this.selectedBeer = selectedBeer;
                  });
                },
              ),
            ),
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
                asyncItems: (String filter) => Future.value(breweries).then((breweries) =>
                    breweries.where((brewery) => brewery.name.contains(filter)).toList()),
                itemAsString: (Brewery b) => b.name,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Select a brewery",
                  ),
                ),
                onChanged: (Brewery? selectedBrewery) {
                  setState(() {
                    this.selectedBrewery = selectedBrewery;
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
                asyncItems: (String filter) => Future.value(types).then((types) =>
                    types.where((type) => type.contains(filter)).toList()),
                itemAsString: (String t) => t,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Select a type",
                  ),
                ),
                onChanged: (String? selectedType) {
                  setState(() {
                    this.selectedType = selectedType;
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
                asyncItems: (String filter) => Future.value(alcoholLevels).then((levels) =>
                    levels.where((level) => level.contains(filter)).toList()),
                itemAsString: (String t) => t,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Select an alcohol level",
                  ),
                ),
                onChanged: (String? selectedLevel) {
                  setState(() {
                    this.selectedLevel = selectedLevel;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
