class Property {
  final int id;
  final String title;
  final String address;
  final double price;
  final String description;

  Property({
    required this.id,
    required this.title,
    required this.address,
    required this.price,
    required this.description,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      address: json['address'] ?? 'No Address',
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
    );
  }
}
