import 'dart:convert';
import 'package:http/http.dart' as http;

class Property {
  String title;
  String description;
  String address;
  double price;
  double electricityCost;
  double waterCost;
  String categoryName;
  bool available;

  Property({
    required this.title,
    required this.description,
    required this.address,
    required this.price,
    required this.electricityCost,
    required this.waterCost,
    required this.categoryName,
    required this.available,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "address": address,
      "price": price,
      "electricityCost": electricityCost,
      "waterCost": waterCost,
      "categoryName": categoryName,
      "available": available,
    };
  }
}

class PropertyService {
  static Future<bool> createProperty(Property property) async {
    final url = Uri.parse(
      "https://propertyrentalapi.onrender.com/api/properties",
    );

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(property.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Property Created");
        print(response.body);
        return true;
      } else {
        print("❌ Failed");
        print(response.body);
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
