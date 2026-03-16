import 'package:flutter/material.dart';
// Make sure these import paths match your project structure
import '../model/property.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Initialize your service
  final ApiService _apiService = ApiService();
  late Future<List<Property>> _propertyFuture;

  @override
  void initState() {
    super.initState();
    // We simulate a 2-second delay then return fake data
    _propertyFuture = Future.delayed(const Duration(seconds: 2), () {
      return [
        Property(
          id: 1,
          title: "Sky View Residence 40",
          address: "Koh Pich, Phnom Penh",
          price: 500.0,
          description: "idk",
        ),
        Property(
          id: 2,
          title: "Modern Condo",
          address: "BKK1, Phnom Penh",
          price: 750.0,
          description: "idk",
        ),
        Property(
          id: 3,
          title: "Penthouse Suite",
          address: "Tul Kork, Phnom Penh",
          price: 1200.0,
          description: "idk",
        ),
        Property(
          id: 4,
          title: "Riverside Apartment",
          address: "Daun Penh, Phnom Penh",
          price: 450.0,
          description: "idk",
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      // Ensure the Stack is the absolute root of the body
      body: Stack(
        children: [
          // LAYER 1: CONTENT (List, Banner, etc.)
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
                      // Even if API fails, the List area will show something
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final properties = snapshot.data ?? [];
                      return ListView.builder(
                        // 120px padding ensures the last card scrolls ABOVE the navbar
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

          // LAYER 2: THE NAVBAR
          // Positioned at the very bottom of the Stack
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          FilterButton(title: "Location"),
          SizedBox(width: 12),
          FilterButton(title: "Sort"),
          SizedBox(width: 12),
          FilterButton(title: "Price"),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          Text("Failed to load: $error"),
          TextButton(
            onPressed: () =>
                setState(() => _propertyFuture = _apiService.fetchProperties()),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}

// --- Component: PropertyCard ---
class PropertyCard extends StatelessWidget {
  final Property property;
  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.blue.shade200,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.address,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${property.price}/Month',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _iconDetail(Icons.apartment, 'Condo'),
                      _iconDetail(Icons.bed, '2 bed'),
                      _iconDetail(Icons.bathtub, '2 Bath'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconDetail(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}

// --- Component: FilterButton ---
class FilterButton extends StatelessWidget {
  final String title;
  const FilterButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // FORCING HEIGHT TO 80 SO IT MUST SHOW
      height: 80,
      margin: const EdgeInsets.only(bottom: 24, left: 32, right: 32),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors
            .white, // Change to Colors.red temporarily to test visibility!
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

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          MainAxisAlignment.center, // Center the items vertically
      children: [
        Icon(
          icon,
          color: isActive ? Colors.blue : Colors.grey.shade300,
          size: 26,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.blue : Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
