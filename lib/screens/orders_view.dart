// lib/screens/orders_view.dart

import 'package:flutter/material.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Active Orders", 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Track and manage incoming meal requests", 
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: const [
              _OrderCard(
                orderId: "#BK-8821",
                customerName: "Juan Dela Cruz",
                packageName: "Ultimate Breakfast Package",
                qty: 2,
                totalPrice: 300,
                status: "Pending",
                time: "10 mins ago",
              ),
              _OrderCard(
                orderId: "#BK-8819",
                customerName: "Maria Clara",
                packageName: "Lunch Value Pack",
                qty: 1,
                totalPrice: 150,
                status: "Preparing",
                time: "25 mins ago",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String orderId, customerName, packageName, status, time;
  final int qty, totalPrice;

  const _OrderCard({
    required this.orderId, required this.customerName, required this.packageName,
    required this.status, required this.time, required this.qty, required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(orderId, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
              _buildStatusBadge(status),
            ],
          ),
          const Divider(height: 24),
          Text(customerName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(packageName, style: TextStyle(color: Colors.grey.shade700)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Qty: $qty", style: const TextStyle(fontWeight: FontWeight.w500)),
              Text("₱$totalPrice", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF6B00), fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const Spacer(),
              _actionButton(status == "Pending" ? "Accept Order" : "Mark Ready", 
                  status == "Pending" ? const Color(0xFFFF6B00) : Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color = status == "Pending" ? Colors.orange : Colors.blue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _actionButton(String label, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}