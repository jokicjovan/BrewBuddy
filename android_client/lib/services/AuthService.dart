import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../assets/constants.dart';

class AuthService {
  final String authServiceUrl = '$baseUrl/auth';

  Future<void> login(String email, String password) async {
    final url = Uri.parse('$authServiceUrl/login');
    final response = await http.post(
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
    } else {
      throw Exception('${response.reasonPhrase}');
    }
  }

  Future<bool> isTokenValid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      return false;
    }

    final url = Uri.parse('$authServiceUrl/validate-token');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      await prefs.remove('token');
    }

    return true;
  }
}
