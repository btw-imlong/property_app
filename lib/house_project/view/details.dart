import 'package:flutter/material.dart';
import 'package:property/house_project/view/house_detail.dart';
import 'package:property/widgets/facility_box.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. BACK BUTTON
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {},
                ),
              ),
            ),

            // 2. FULL SCREEN IMAGE (Under Back Button)
            Center(
              // Added to put the image in the center
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?auto=format&fit=crop&w=1000&q=80',
                    height: 350,
                    width: 350,
                    fit: BoxFit.cover,
                    // Shows while the image is downloading
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 350,
                        width: 350,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    // Error handling if the link breaks
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 350,
                      width: 350,
                      color: const Color.fromARGB(255, 146, 40, 40),
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 3. RENT HOUSE HEADING & RATE NOW
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Rent House",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add your rating logic here
                      print("Rate now pressed");
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets
                          .zero, // Removes extra padding around the text
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      "Rate now",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 4. STAR RATING (Under Title)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  Icon(Icons.star_half, color: Colors.orange, size: 20),
                  SizedBox(width: 5),
                  Text(
                    "4.5 (355 Reviews)",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            // 5. DESCRIPTION (Under Star Rating)
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining shopping and ....",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),

            // 6. FACILITIES HEADING
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: InkWell(
                onTap: () {
                  // Navigates to the HouseDetailView page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HouseDetailView(),
                    ),
                  );
                },
                child: const Text(
                  "See more...",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            // 7. FACILITIES (Fixed Overflow using Expanded)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: const [
                  Expanded(
                    child: FacilityBox(icon: Icons.wifi, label: "WiFi"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: FacilityBox(icon: Icons.kitchen, label: "Kitchen"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: FacilityBox(icon: Icons.pool, label: "Pool"),
                  ),
                ],
              ),
            ),
            // 8. THE BOTTOM PRICE BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: InkWell(
                // InkWell adds a nice ripple effect when clicked
                child: const Text(
                  "Price:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: InkWell(
                // InkWell adds a nice ripple effect when clicked
                child: const Text(
                  "\$100 / month",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
