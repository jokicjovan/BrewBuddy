import 'dart:convert';

import 'package:BrewBuddy/interceptors/AuthInterceptor.dart';
import 'package:BrewBuddy/models/Brewery.dart';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../assets/constants.dart';

class BreweryService{
  final String breweryServiceUrl = '$baseUrl/brewery';
  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);
  Future<List<Brewery>> getBreweries () async {
    final response = await client.get(Uri.parse("$breweryServiceUrl/"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Brewery.fromJson(json)).toList();
    }
    throw Exception("Exception while loading breweries: ${response.reasonPhrase}");
  }

  Future<List<Brewery>> getPopularBreweries() async {
    final response = await client.get(Uri.parse("$breweryServiceUrl/popular"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Brewery.fromJson(json)).toList();
    }
    throw Exception("Exception while loading popular breweries: ${response.reasonPhrase}");
  }
  Future<Brewery> getBrewery (int id) async {
    final response = await client.get(Uri.parse("$breweryServiceUrl/$id"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Brewery.fromJson(jsonData);
    } else {
      throw Exception('Failed to load brewery');
    }
  }
}