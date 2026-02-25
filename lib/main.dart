// main.dart
import 'package:flutter/material.dart';
import 'package:property/house_project/view/details.dart'; // Start with the first page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailPage(), // Set this to your initial DetailPage
    );
  }
}
