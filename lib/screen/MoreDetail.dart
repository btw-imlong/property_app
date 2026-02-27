// ignore file:name
import 'package:flutter/material.dart';

void _openZoomView(BuildContext context, String activeImage) {}

class MoreDetail extends StatefulWidget {
  const MoreDetail({super.key, required List<dynamic> images});

  @override
  State<MoreDetail> createState() => MoreDetailState();
}

class MoreDetailState extends State<MoreDetail> {
  final List<String> images = [
    'https://expertrealty.com.kh/new/wp-content/uploads/2019/11/WEB-36-4.jpg',
    'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=500', // Bathroom
    'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=500', // Bedroom
    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=500', // Living room
  ];

  late String activeImage;

  @override
  void initState() {
    super.initState();
    activeImage = images[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // 1. Wrap the Big Image and the Back Button in a STACK
                  Stack(
                    children: [
                      // THE BIG IMAGE
                      GestureDetector(
                        onTap: () => _openZoomView(context, activeImage),
                        child: Hero(
                          tag: 'main_img',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              'https://corsproxy.io/?$activeImage',
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      // 2. THE BACK BUTTON (Now correctly positioned inside the Stack)
                      Positioned(
                        top: 15, // Distance from top of the image
                        left: 15, // Distance from left of the image
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ... (Your Thumbnails Row stays here)
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...images.map((url) {
                        bool isActive = activeImage == url;
                        return GestureDetector(
                          onTap: () => setState(() => activeImage = url),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: isActive
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://corsproxy.io/?$url',
                                height: 60,
                                width:
                                    (MediaQuery.of(context).size.width - 80) /
                                    5,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ),
            //TEXT CONTENT UI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Rent House",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      Text(
                        "Phnom Penh, Cambodia",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "luxury two bedroom for rent",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Add an emoji or a bullet point to the first two lines
                  _infoTile("🏠", "Type: two bedroom"),
                  _infoTile("🛋️", "Full Furniture"),
                  _infoTile("💰", "Rental price: 100/\$month"),
                  _infoTile("📍", "Location: Phnom Penh, Cambodia"),
                  _infoTile("📞", "Call us for more information"),
                  _infoTile(
                    "📱",
                    "092879xxx Click to Call",
                  ), // Added an icon here too

                  const SizedBox(height: 15),
                  _infoTile("👉", "WhatsApp: https://wa.me/85592879746"),
                  _infoTile("👉", "Telegram: https://t.me/c21c21c21"),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String leading, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(leading, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
