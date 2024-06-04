


import 'dart:convert';

import 'package:BrewBuddy/interceptors/AuthInterceptor.dart';
import 'package:BrewBuddy/models/Beer.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../assets/constants.dart';

class BeerService{
  final String beerServiceUrl = '$baseUrl/beer';
  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);
  Future<List<Beer>> getPopularBeers () async {
    final response = await client.get(Uri.parse("$beerServiceUrl/popular"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Beer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load beers');
    }
  }
  Future<List<String>> getPopularBeerTypes () async {
    final response = await client.get(Uri.parse("$beerServiceUrl/beerType/popular"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => json.toString()).toList();
    } else {
      throw Exception('Failed to load popular Beer Types');
    }
  }

  Future<List<Beer>> getBeersByType (String type) async {
    final response = await client.get(Uri.parse("$beerServiceUrl/type/$type"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Beer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load beers by type');
    }
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
    } else {
      throw Exception('Failed to load beers by type');
    }
  }

  Future<Beer> getBeer (int id) async {
    final response = await client.get(Uri.parse("$beerServiceUrl/$id"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Beer.fromJson(jsonData);
    } else {
      throw Exception('Failed to load beer');
    }
  }
}