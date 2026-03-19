import 'package:flutter/material.dart';

import '../screens/DetailPage.dart';
import '../model/property.dart';
import '../screens/home_page.dart' hide Property;

class AppRoutes {
  static const home = "/";
  static const detail = "/detail";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case detail:
        final property = settings.arguments as Property;

        return MaterialPageRoute(
          builder: (_) => DetailPage(property: property),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
