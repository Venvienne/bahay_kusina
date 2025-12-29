// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'home_page.dart'; // Target for Customer signup
import 'vendor_home_page.dart'; // Target for Vendor signup
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Define constant colors
  static const Color primaryOrange = Color(0xFFFF6B00);
  static const Color secondaryOrange = Color(0xFFFF8C3B);
  static const Color inputFillColor = Color(0xFFEEEEEE);

  // Default role is Customer
  String selectedRole = "Customer";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _submitSignUp() {
    // For demonstration, we simply navigate based on the selected role:
    final targetPage = selectedRole == "Customer" ? const HomePage() : const VendorHomePage();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Signing up as $selectedRole..."),
        backgroundColor: secondaryOrange,
      ),
    );

    // Navigate to the respective home page upon successful registration
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ---------- TOP HEADER ----------
            _buildHeader(context),
            
            // ---------- FORM AREA ----------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Role Selector
                    const Text(
                      "I want to sign up as a",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    _buildRoleSelector(),

                    const SizedBox(height: 25),

                    // Full Name Input
                    const Text("Full Name"),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _nameController,
                      hint: "Juan Dela Cruz",
                      keyboardType: TextInputType.name,
                    ),

                    const SizedBox(height: 20),

                    // Email/Phone Input
                    const Text("Email or Phone"),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _emailPhoneController,
                      hint: "juan@example.com or 09171234567",
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 20),

                    // Password Input
                    const Text("Password"),
                    const SizedBox(height: 8),
                    _buildPasswordTextField(
                      controller: _passwordController,
                      hint: "Create your password",
                      isConfirm: false,
                    ),
                    
                    const SizedBox(height: 20),

                    // Confirm Password Input
                    const Text("Confirm Password"),
                    const SizedBox(height: 8),
                    _buildPasswordTextField(
                      controller: _confirmPasswordController,
                      hint: "Re-enter password",
                      isConfirm: true,
                    ),

                    const SizedBox(height: 30),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitSignUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Already have an account link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            // --- CONNECTED TO LOGIN ---
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(initialRole: selectedRole),
                                ),
                              );
                            },
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                color: primaryOrange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- EXTRACTED WIDGETS/METHODS ----------

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryOrange, secondaryOrange],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.arrow_back, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text(
                  "Back",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Text(
              "Join the BahayKusina community!",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Row(
      children: [
        _roleButton("Customer"),
        const SizedBox(width: 10),
        _roleButton("Vendor"),
      ],
    );
  }

  Widget _roleButton(String role) {
    bool isSelected = selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRole = role;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? secondaryOrange.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? secondaryOrange : Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected)
                const Padding(
                  padding: EdgeInsets.only(right: 6.0),
                  child: Text(
                    "•",
                    style: TextStyle(
                      fontSize: 18,
                      color: primaryOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Text(
                role,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? primaryOrange : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color.fromARGB(255, 254, 253, 253),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required String hint,
    required bool isConfirm,
  }) {
    bool currentObscure = isConfirm ? obscureConfirmPassword : obscurePassword;

    return TextField(
      controller: controller,
      obscureText: currentObscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 254, 254),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        suffixIcon: IconButton(
          icon: Icon(
            currentObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              if (isConfirm) {
                obscureConfirmPassword = !obscureConfirmPassword;
              } else {
                obscurePassword = !obscurePassword;
              }
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}