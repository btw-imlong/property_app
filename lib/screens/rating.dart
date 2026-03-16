// import 'package:flutter/material.dart';

// class PropertyDetailPage extends StatefulWidget {
//   const PropertyDetailPage({super.key});

//   @override
//   State<PropertyDetailPage> createState() => _PropertyDetailPageState();
// }

// class _PropertyDetailPageState extends State<PropertyDetailPage> {
//   int rating = 4;

//   Widget buildStar(int index) {
//     return IconButton(
//       onPressed: () {
//         setState(() {
//           rating = index;
//         });
//       },
//       icon: Icon(
//         index <= rating ? Icons.star : Icons.star_border,
//         color: Colors.amber,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],

//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(18),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Property Image
//                 Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image.network(
//                         "https://images.unsplash.com/photo-1505843513577-22bb7d21e455",
//                         height: 250,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                     ),

//                     /// Back Button
//                     Positioned(
//                       top: 10,
//                       left: 10,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: IconButton(
//                           icon: const Icon(Icons.arrow_back),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 /// Title
//                 const Text(
//                   "Rent House",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),

//                 const SizedBox(height: 6),

//                 /// Rating + reviews
//                 Row(
//                   children: const [
//                     Icon(Icons.star, color: Colors.amber, size: 18),
//                     SizedBox(width: 5),
//                     Text(
//                       "4.5 (355 Reviews)",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 10),

//                 /// Description
//                 const Text(
//                   "Aspen is as close as one can get to a storybook alpine town in America. "
//                   "The choose-your-own-adventure possibilities—skiing, hiking, dining, "
//                   "shopping and ...",
//                   style: TextStyle(color: Colors.black54, height: 1.5),
//                 ),

//                 const SizedBox(height: 5),

//                 /// Read more
//                 const Text(
//                   "Read more",
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 /// Rating Stars
//                 Row(
//                   children: [
//                     buildStar(1),
//                     buildStar(2),
//                     buildStar(3),
//                     buildStar(4),
//                     buildStar(5),
//                   ],
//                 ),

//                 const SizedBox(height: 10),

//                 /// Comment title
//                 const Text(
//                   "Comment",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),

//                 const SizedBox(height: 10),

//                 /// Comment Box
//                 TextField(
//                   maxLines: 5,
//                   decoration: InputDecoration(
//                     hintText: "Write comment here ...............",
//                     filled: true,
//                     fillColor: Colors.grey[300],
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 /// Submit Button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: const Text(
//                       "Submit Review",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
