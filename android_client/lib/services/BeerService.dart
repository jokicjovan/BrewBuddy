import 'dart:convert';

import 'package:BrewBuddy/interceptors/AuthInterceptor.dart';
import 'package:BrewBuddy/models/Beer.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../assets/constants.dart';

class BeerService {
  final String beerServiceUrl = '$baseUrl/beer';
  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  Future<List<Beer>> getAllBeers() async {
    final response = await client.get(Uri.parse("$beerServiceUrl/"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Beer.fromJson(json)).toList();
    }
    throw Exception("Exception while loading beers: ${response.reasonPhrase}");
  }

  Future<List<Beer>> getPopularBeers() async {
    final response = await client.get(Uri.parse("$beerServiceUrl/popular"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Beer.fromJson(json)).toList();
    }
    throw Exception(
        "Exception while loading popular beers: ${response.reasonPhrase}");
  }

  Future<List<String>> getBeerTypes() async {
    final response = await client.get(Uri.parse("$beerServiceUrl/beerTypes"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => json.toString()).toList();
    }
    throw Exception(
        "Exception while loading popular beers: ${response.reasonPhrase}");
  }

  Future<bool> logBeer(Beer beer) async {
    final response = await client
        .post(Uri.parse("$beerServiceUrl/log?beerId=${beer.id.toString()}"));

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception("Exception while logging beer: ${response.reasonPhrase}");
  }

  Future<bool> isBeerRated(Beer beer) async {
    final response = await client.get(
        Uri.parse("$beerServiceUrl/isBeerRated?beerId=${beer.id.toString()}"));

    if (response.statusCode == 200) {
      return response.body.toLowerCase() == "true";
    }
    throw Exception(
        "Exception while checking is beer rated: ${response.reasonPhrase}");
  }

  Future<bool> rateBeer(Beer beer, int rate, String comment) async {
    final response = await client.post(
        Uri.parse("$beerServiceUrl/rate?beerId=${beer.id.toString()}"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'rate': rate.toString(),
          'comment': comment,
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
    throw Exception("Exception while rating beer: ${response.reasonPhrase}");
  }

  Future<List<String>> getPopularBeerTypes() async {
    final response =
        await client.get(Uri.parse("$beerServiceUrl/beerType/popular"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => json.toString()).toList();
    }
    throw Exception('Exception while loading popular beer types: ${response.reasonPhrase}');
  }

  Future<List<Beer>> getBeersByType(String type) async {
    final response = await client.get(Uri.parse("$beerServiceUrl/type/$type"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Beer.fromJson(json)).toList();
    }
    throw Exception('Exception while loading beers by types: ${response.reasonPhrase}');
  }

  Future<List<Beer>> filterBeers ({String type="",String alcohol="",String breweryId=""}) async {
    String uri="$beerServiceUrl/filter";
    if (type!=""){
      uri+="?beerType=$type&";
    }
    if (alcohol!=""){
      uri+="?alcoholCategory=$alcohol&";
    }
    if (breweryId!=""){
      uri+="?breweryId=$breweryId&";
    }
    final response = await client.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Beer.fromJson(json)).toList();
    }
    throw Exception('Exception while loading beers with filter: ${response.reasonPhrase}');
  }

  Future<Beer> getBeer (int id) async {
    final response = await client.get(Uri.parse("$beerServiceUrl/$id"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Beer.fromJson(jsonData);
    }
    throw Exception('Exception while loading beer: ${response.reasonPhrase}');
  }
}
