import 'package:flutter/material.dart';

class FacilityBox extends StatelessWidget {
  final IconData icon;
  final String label;

  const FacilityBox({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.black, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontFamily: "Roboto",
            ),
          ),
        ],
      ),
    );
  }
}
