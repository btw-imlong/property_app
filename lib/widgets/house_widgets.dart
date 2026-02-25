import 'package:flutter/material.dart';

class HouseImageGallery extends StatelessWidget {
  final String mainImage;
  final List<String> thumbs;

  const HouseImageGallery({
    super.key,
    required this.mainImage,
    required this.thumbs,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            mainImage,
            height: 350,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: thumbs.map((url) => _buildThumb(url)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildThumb(String url) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(url, width: 70, height: 70, fit: BoxFit.cover),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String emoji;
  final String text;
  const DetailRow({super.key, required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}

class ContactLink extends StatelessWidget {
  final String platform;
  final String link;
  const ContactLink({super.key, required this.platform, required this.link});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text.rich(
        TextSpan(
          text: '👉 $platform : ',
          style: const TextStyle(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: link,
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
