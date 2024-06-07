


import 'dart:convert';

import 'package:BrewBuddy/interceptors/AuthInterceptor.dart';
import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Festival.dart';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../assets/constants.dart';

class UserService{
  final String userServiceUrl = '$baseUrl/user';
  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  Future<List<Beer>> getBeerRecommendation() async {
    final response = await client.get(Uri.parse('$userServiceUrl/beer/recommend'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Beer.fromJson(json)).toList();
    }
    throw Exception("Exception while getting recommended beers: ${response.reasonPhrase}");
  }

  Future<List<Festival>> getFestivalRecommendation() async {
    final response = await client.get(Uri.parse('$userServiceUrl/festival/recommend'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => Festival.fromJson(json)).toList();
    }
    throw Exception("Exception while getting recommended festivals: ${response.reasonPhrase}");
  }

  Future<bool> isUserDrunk() async {
    final response = await client.get(Uri.parse('$userServiceUrl/isDrunk'));
    if (response.statusCode == 200) {
      return response.body=="true";
    }
    throw Exception("Exception while checking if user is drunk: ${response.reasonPhrase}");
  }

  Future<List<String>> getPopularUsers() async {
    final response = await client.get(Uri.parse("$userServiceUrl/popular"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((json) => json.toString()).toList();
    }
    throw Exception(
        "Exception while loading popular users: ${response.reasonPhrase}");
  }
}