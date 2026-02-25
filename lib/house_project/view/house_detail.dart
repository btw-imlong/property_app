import 'package:flutter/material.dart';
import 'package:property/models/house.dart';
import 'package:property/widgets/house_widgets.dart';

class HouseDetailView extends StatelessWidget {
  const HouseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final myHouse = House(
      title: "Rent House | for rent in Tonle Bassac",
      price: "100\$",
      location: "Chamkar Mon, Phnom Penh",
      imageUrl:
          "https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800",
      thumbnails: [
        "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=200",
        "https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=200",
        "https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=200",
      ],
      description: "Luxury two bedroom for rent 💚",
      contactLinks: {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: HouseImageGallery(
                mainImage: myHouse.imageUrl,
                thumbs: myHouse.thumbnails,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${myHouse.title}| ${myHouse.price}/ month',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '📍 ${myHouse.location}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    myHouse.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const DetailRow(emoji: '🍀', text: 'Type: two bedroom'),
                  const DetailRow(emoji: '🍀', text: 'Rental price: 100\$'),
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      '092879xxx Click To Call',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const ContactLink(
                    platform: 'WhatsApp',
                    link: 'https://wa.me/85592879746',
                  ),
                  const ContactLink(
                    platform: 'Telegram',
                    link: 'https://t.me/c21c21c21',
                  ),
                  const Divider(height: 50),
                  const Text(
                    'Llink : https://cambodia-real-estate.com',
                    style: TextStyle(color: Colors.blue),
                  ),
                  const Text(
                    '公寓出租 💚 🍀类型：2房',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const DetailRow(emoji: '🍀', text: '全部家具'),
                  const DetailRow(emoji: '🍀', text: '租金：750\$'),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
