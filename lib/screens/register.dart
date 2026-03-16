import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPasswordVisible = true;

  bool get isPasswordHidden => !isPasswordVisible;

  // Controllers for inputs
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  void dispose() {
    // Dispose controllers
    fullnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    final url = Uri.parse(
      "https://propertyrentalapi.onrender.com/api/auth/register",
    );

    final body = {
      "fullname": fullnameController.text,
      "username": usernameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "phone": phoneController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${error['message'] ?? 'Unknown'}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                      (route) => false,
                    );
                  },
                ),

                const SizedBox(height: 10),

                /// Title
                const Text(
                  "Let’s explore together!",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Create your Placoo account to explore your dream place to live across the whole world!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 83, 82, 82),
                  ),
                ),

                const SizedBox(height: 20),

                /// Fullname
                buildInput(
                  "Fullname",
                  "Enter your fullname",
                  controller: fullnameController,
                ),

                const SizedBox(height: 15),

                /// Username
                buildInput(
                  "Username",
                  "Enter your username",
                  controller: usernameController,
                ),

                const SizedBox(height: 15),

                /// Email
                buildInput(
                  "Email",
                  "Enter your email",
                  controller: emailController,
                ),

                const SizedBox(height: 15),

                /// Password
                buildInput(
                  "Password",
                  "••••••••",
                  isPassword: true,
                  controller: passwordController,
                ),

                const SizedBox(height: 15),

                /// Phone
                buildInput(
                  "Phone Number",
                  "Enter your phone number",
                  controller: phoneController,
                ),

                const SizedBox(height: 25),

                /// Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D6CDF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: registerUser,
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Sign in text
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Do you have an account? ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign in",
                          style: const TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Input widget
  Widget buildInput(
    String label,
    String hint, {
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),

        const SizedBox(height: 6),

        TextField(
          controller: controller,

          obscureText: isPassword ? isPasswordHidden : false,

          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),

            /// 👁 Eye icon
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
