import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContactButton extends StatelessWidget {
  final String platform;
  final String link;

  const ContactButton({super.key, required this.platform, required this.link});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.link, color: Colors.orange),
      title: Text(
        "$platform : $link",
        style: const TextStyle(fontSize: 13, color: Colors.blue),
      ),
      onTap: () {
        // This is where you would launch the URL later
        if (kDebugMode) {
          print("Opening $platform");
        }
      },
    );
  }
}
