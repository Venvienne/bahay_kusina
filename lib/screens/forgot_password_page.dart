import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  // 1. THIS IS THE KEY CHANGE: Receiving the role from the Login Page
  final String userRole; 
  
  const ForgotPasswordPage({super.key, required this.userRole});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // Constants to match your BahayKusina branding
  static const Color primaryOrange = Color(0xFFFF6B00);
  static const Color secondaryOrange = Color(0xFFFF8C3B);
  static const Color inputFillColor = Color(0xFFEEEEEE);

  final TextEditingController _emailController = TextEditingController();

  void _submitResetRequest() {
    String input = _emailController.text;
    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email or phone")),
      );
      return;
    }

    // 2. CHANGE: Mentioning the role in the confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Reset link sent to $input for ${widget.userRole} account."),
        backgroundColor: secondaryOrange,
        duration: const Duration(seconds: 3),
      ),
    );
    
    // Go back to login after showing the message
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Match Login background
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Reset your Password", 
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Enter your registered email address or phone number. We will send you instructions to reset your password.",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 30),
                    
                    const Text("Email or Phone", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _emailController,
                      hint: "e.g., juan@example.com or 09171234567",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Reset Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitResetRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Send Reset Link", 
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Link back to Login
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Back to Log In", 
                          style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold)
                        ),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 40),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryOrange, secondaryOrange], 
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30), 
          bottomRight: Radius.circular(30)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text(
            "Security Check", 
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 5),
          // 3. CHANGE: Displaying the active role clearly in the header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Account type: ${widget.userRole}", 
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller, 
    required String hint, 
    required TextInputType keyboardType
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: inputFillColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), 
          borderSide: BorderSide.none
        ),
      ),
    );
  }
}