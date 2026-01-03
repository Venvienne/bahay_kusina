import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // For rich text links
import '../theme/app_colors.dart';
import '../widgets/signup_text_field.dart';
import 'home_page.dart';
import 'vendor_home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String selectedRole = "Order Food";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _handleSignUp() {
    final targetPage = selectedRole == "Order Food" ? const HomePage() : const VendorHomePage();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Signing up to $selectedRole..."), backgroundColor: AppColors.secondaryOrange),
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => targetPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("I want to"),
                    const SizedBox(height: 10),
                    _buildRoleSelector(),
                    const SizedBox(height: 25),
                    
                    _buildLabel("Full Name"),
                    SignupTextField(controller: _nameController, hint: "Juan Dela Cruz", keyboardType: TextInputType.name),
                    
                    const SizedBox(height: 20),
                    _buildLabel("Email"),
                    SignupTextField(controller: _emailPhoneController, hint: "juan@example.com", keyboardType: TextInputType.emailAddress),
                    
                    const SizedBox(height: 20),
                    _buildLabel("Phone Number"),
                    SignupTextField(controller: _phoneController, hint: "09171234567", keyboardType: TextInputType.phone),
                    
                    const SizedBox(height: 20),
                    _buildLabel("Delivery Address"),
                    SignupTextField(controller: _addressController, hint: "123 Mabini St., Barangay San Juan, Manila", keyboardType: TextInputType.streetAddress),

                    const SizedBox(height: 20),
                    _buildLabel("Password"),
                    SignupTextField(
                      controller: _passwordController,
                      hint: "At least 8 characters",
                      isPassword: true,
                      obscureText: obscurePassword,
                      onToggleVisibility: () => setState(() => obscurePassword = !obscurePassword),
                    ),
                    
                    const SizedBox(height: 20),
                    _buildLabel("Confirm Password"),
                    SignupTextField(
                      controller: _confirmPasswordController,
                      hint: "Re-enter your password",
                      isPassword: true,
                      obscureText: obscureConfirmPassword,
                      onToggleVisibility: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
                    ),

                    const SizedBox(height: 30),
                    _buildTermsAndConditions(),
                    const SizedBox(height: 20),
                    _buildSubmitButton(),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 30),
      decoration: const BoxDecoration(
        color: AppColors.primaryOrange, // Solid orange header
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 20),
          const Text("Join our community today", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), // Updated title
        ],
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Row(
      children: ["Order Food", "Sell Food"].map((role) {
        bool isSelected = selectedRole == role;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedRole = role),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isSelected ? AppColors.primaryOrange : const Color.fromARGB(255, 255, 254, 254), width: 1.5), // Orange border for selected
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isSelected)
                    const Padding(padding: EdgeInsets.only(right: 8), child: Icon(Icons.circle, size: 8, color: Colors.black)), // Black dot for selected
                  Text(role, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.black : Colors.black87)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTermsAndConditions() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(color: Colors.black54, fontSize: 13),
        children: [
          const TextSpan(text: "By signing up, you agree to our "),
          TextSpan(
            text: "Terms of Service",
            style: const TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.bold), // Orange links
            recognizer: TapGestureRecognizer()..onTap = () {}, // Add navigation logic here
          ),
          const TextSpan(text: " and "),
          TextSpan(
            text: "Privacy Policy",
            style: const TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _handleSignUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryOrange, // Solid orange button
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}