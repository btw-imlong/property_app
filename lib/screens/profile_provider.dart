import 'package:flutter/material.dart';

class ProfileProviderScreen extends StatelessWidget {
  const ProfileProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Provider"), centerTitle: true),

      body: const Center(
        child: Text(
          "Welcome to Profile Provider Page",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
