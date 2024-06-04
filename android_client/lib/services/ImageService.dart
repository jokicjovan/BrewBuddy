
import 'dart:typed_data';

import 'package:BrewBuddy/interceptors/AuthInterceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../assets/constants.dart';

class ImageService{
  final String imageServiceUrl = '$baseUrl/image';
  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);
  Future<Uint8List> getBeerImage (String name) async {
    final response = await client.get(Uri.parse("$imageServiceUrl/beer/$name"));

    if (response.statusCode == 200) {
      final jsonData = response.bodyBytes;
      return jsonData;
    }
    throw Exception("Exception while loading beer image: ${response.reasonPhrase}");
  }
  Future<Uint8List> getBreweryImage (String name) async {
    final response = await client.get(Uri.parse("$imageServiceUrl/brewery/$name"));

    if (response.statusCode == 200) {
      final jsonData = response.bodyBytes;
      return jsonData;
    }
    throw Exception("Exception while loading brewery image: ${response.reasonPhrase}");
  }
}