


import 'dart:convert';

import 'package:BrewBuddy/interceptors/AuthInterceptor.dart';
import 'package:BrewBuddy/models/Beer.dart';
import 'package:BrewBuddy/models/Festival.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../assets/constants.dart';

class FestivalService{
  final String festivalServiceUrl = '$baseUrl/festival';
  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  Future<Festival> getFestival (int id) async {
    final response = await client.get(Uri.parse("$festivalServiceUrl/$id"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Festival.fromJson(jsonData);
    } else {
      throw Exception('Failed to load festival');
    }
  }
}