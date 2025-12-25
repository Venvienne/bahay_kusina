import 'package:flutter/material.dart';

class VendorHomePage extends StatelessWidget {
  const VendorHomePage({super.key});

  static const Color primaryOrange = Color(0xFFFF6B00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor Dashboard"),
        backgroundColor: primaryOrange,
      ),
      body: const Center(
        child: Text("Welcome to the Vendor Dashboard! (To be Implemented)"),
      ),
    );
  }
}