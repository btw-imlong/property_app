import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/property.dart';

class ApiService {
  final String baseUrl = "https://propertyrentalapi.onrender.com/api";

  Future<List<Property>> fetchProperties() async {
    final response = await http.get(Uri.parse('$baseUrl/properties'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List<dynamic> items = body['data']['items'];
      return items.map((json) => Property.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load properties');
    }
  }
}
