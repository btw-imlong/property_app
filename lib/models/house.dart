class House {
  final String imageUrl;
  final List<String> thumbnails;
  final String title;
  final String location;
  final String price;
  final String description;
  final Map<String, String> contactLinks;

  House({
    required this.imageUrl,
    required this.thumbnails,
    required this.title,
    required this.location,
    required this.price,
    required this.description,
    required this.contactLinks,
  });
}
