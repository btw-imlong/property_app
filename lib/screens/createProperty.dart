import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/property.dart';

class CreatepropertyScreen extends StatefulWidget {
  const CreatepropertyScreen({super.key});

  @override
  State<CreatepropertyScreen> createState() => _CreatepropertyScreenState();
}

class _CreatepropertyScreenState extends State<CreatepropertyScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final priceController = TextEditingController();
  final electricityController = TextEditingController();
  final waterController = TextEditingController();
  final categoryController = TextEditingController();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> publishProperty() async {
    Property property = Property(
      title: titleController.text,
      description: descriptionController.text,
      address: addressController.text,
      price: double.parse(priceController.text),
      electricityCost: double.parse(electricityController.text),
      waterCost: double.parse(waterController.text),
      categoryName: categoryController.text,
      available: true,
    );

    bool success = await PropertyService.createProperty(property);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Property created successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create property")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Create Property"),
        centerTitle: true,
        backgroundColor: const Color(0xffffffff),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel("Property Title"),
            buildInput("Enter property title", controller: titleController),

            const SizedBox(height: 16),

            buildLabel("Description"),
            buildInput(
              "Enter description",
              controller: descriptionController,
              maxLines: 4,
            ),

            const SizedBox(height: 16),

            buildLabel("Address"),
            buildInput("Enter address", controller: addressController),

            const SizedBox(height: 16),

            buildLabel("Price"),
            buildInput("Enter price", controller: priceController),

            const SizedBox(height: 16),

            buildLabel("Electric Cost"),
            buildInput(
              "Enter electric cost",
              controller: electricityController,
            ),

            const SizedBox(height: 16),

            buildLabel("Water Cost"),
            buildInput("Enter water cost", controller: waterController),

            const SizedBox(height: 16),

            buildLabel("Category"),
            buildInput("Enter category", controller: categoryController),

            const SizedBox(height: 16),

            buildLabel("Property Images"),

            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),

                child: _selectedImage == null
                    ? const Center(child: Text("Click to upload image"))
                    : Image.file(_selectedImage!, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: publishProperty,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D6CDF),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Publish Property"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget buildInput(
    String hint, {
    TextEditingController? controller,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
