import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl =
      "https://propertyrentalapi.onrender.com/api/auth";

  static Future<Map<String, dynamic>> register({
    required String fullname,
    required String username,
    required String email,
    required String password,
    required String phone,
  }) async {
    final url = Uri.parse("$baseUrl/register");

    final body = {
      "fullname": fullname,
      "username": username,
      "email": email,
      "password": password,
      "phone": phone,
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    return {
      "statusCode": response.statusCode,
      "data": jsonDecode(response.body),
    };
  }
}
