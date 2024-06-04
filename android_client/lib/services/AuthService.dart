import 'dart:convert';
import 'package:BrewBuddy/interceptors/AuthInterceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../assets/constants.dart';

class AuthService {
  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);
  final String authServiceUrl = '$baseUrl/auth';

  Future<void> login(String email, String password) async {
    final url = Uri.parse('$authServiceUrl/login');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return;
    }
    throw Exception('Exception while logging in: ${response.reasonPhrase}');
  }

  Future<bool> isTokenValid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      return false;
    }

    final url = Uri.parse('$authServiceUrl/validate-token');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      await prefs.remove('token');
      return false;
    }
    return true;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String> getRole() async {
    final response = await client.get(Uri.parse("$authServiceUrl/role"));

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to load role');
    }
  }
}
