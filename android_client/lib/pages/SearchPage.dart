import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Brewery.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'BeerPage.dart';

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

  Brewery? selectedBrewery;
  String? selectedType;
  String? selectedLevel;

  List<Beer> filteredBeers = [];
  String query = '';
  TextEditingController _controller = TextEditingController();
  bool showFilters = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    setState(() {
      beers = Beer.getBeers();
      breweries = Brewery.getBreweries();
      types = ["ALE", "IPA", "PILSNER"];
      alcoholLevels = ["LOW", "MEDIUM", "HIGH"];
      filteredBeers = beers;
    });
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
                border: OutlineInputBorder(),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
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
              return buildBeerCard(index, context);
            },
          )),
        ],
      ),
    );
  }

  GestureDetector buildBeerCard(int index, BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BeerPage(
                beerId: filteredBeers[index].id,
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
              Image.asset(
                "assets/beer.png",
                width: 120,
                height: 120,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        filteredBeers[index].type,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${filteredBeers[index].percentageOfAlcohol}%",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    filteredBeers[index].name,
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
                    filteredBeers[index].brewery.name,
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
