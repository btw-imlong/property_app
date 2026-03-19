import 'package:flutter/material.dart';
import '../model/property.dart';
import '../services/api_service.dart';
import './DetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  late Future<List<Property>> _propertyFuture;

  @override
  void initState() {
    super.initState();

    _propertyFuture = Future.delayed(const Duration(seconds: 2), () {
      return [
        Property(
          id: 1,
          title: "Sky View Residence 40",
          address: "Koh Pich, Phnom Penh",
          price: 500.0,
          description: "Nice condo with city view",
        ),
        Property(
          id: 2,
          title: "Modern Condo",
          address: "BKK1, Phnom Penh",
          price: 750.0,
          description: "Luxury modern condo",
        ),
        Property(
          id: 3,
          title: "Penthouse Suite",
          address: "Toul Kork, Phnom Penh",
          price: 1200.0,
          description: "Premium penthouse",
        ),
        Property(
          id: 4,
          title: "Riverside Apartment",
          address: "Daun Penh, Phnom Penh",
          price: 450.0,
          description: "Near riverside",
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBanner(),
                        const SizedBox(height: 16),
                        _buildSearchBar(),
                        const SizedBox(height: 16),
                        _buildFilterRow(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Property>>(
                    future: _propertyFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final properties = snapshot.data ?? [];

                      return ListView.builder(
                        padding: const EdgeInsets.only(
                          bottom: 120,
                          left: 16,
                          right: 16,
                        ),
                        itemCount: properties.length,
                        itemBuilder: (context, index) {
                          return PropertyCard(property: properties[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Positioned(bottom: 0, left: 0, right: 0, child: CustomNavBar()),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          const Text(
            'GET YOUR 20% CASH BACK',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Positioned(
            right: -20,
            top: -20,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Search Property',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Icon(Icons.tune, color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterButton(title: "Location"),
          SizedBox(width: 12),
          FilterButton(title: "Sort"),
          SizedBox(width: 12),
          FilterButton(title: "Price"),
        ],
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(property: property),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: Image.network(
                'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
                width: 130,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      property.address,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "\$${property.price}/Month",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String title;

  const FilterButton({super.key, required this.title});

  void _showOptions(BuildContext context) {
    List<String> options = [];

    if (title == "Location") {
      options = ["All", "BKK1", "Koh Pich", "Toul Kork", "Daun Penh"];
    } else if (title == "Sort") {
      options = ["Newest", "Price Low → High", "Price High → Low"];
    } else if (title == "Price") {
      options = ["\$0 - \$500", "\$500 - \$1000", "\$1000+"];
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: options.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(options[index]),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${options[index]} selected")),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showOptions(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 6),
            const Icon(Icons.keyboard_arrow_down, size: 18),
          ],
        ),
      ),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 24, left: 32, right: 32),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_rounded, "Home", true),
          _navItem(Icons.favorite_outline_rounded, "Favorite", false),
          _navItem(Icons.person_outline_rounded, "Profile", false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? Colors.blue : Colors.grey),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: active ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }
}
