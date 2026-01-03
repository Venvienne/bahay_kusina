// lib/screens/track_order_page.dart
import 'package:flutter/material.dart';

class TrackOrderPage extends StatelessWidget {
  final String orderId;
  final String riderName;
  final String eta;
  final String deliveryAddress;

  const TrackOrderPage({
    super.key,
    required this.orderId,
    required this.riderName,
    required this.eta,
    required this.deliveryAddress,
  });

  static const Color primaryOrange = Color(0xFFFF6B00);
  static const Color successGreen = Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order #$orderId',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map Placeholder Section
            _buildMapSection(),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Status Timeline
                  _buildOrderStatusSection(),
                  const SizedBox(height: 30),

                  // Delivery Info
                  _buildDeliveryInfoSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      width: double.infinity,
      height: 280,
      color: Colors.grey.shade200,
      child: Stack(
        children: [
          // Placeholder Map
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.map, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Real-time Map Tracking\nGoogle Maps Integration',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Rider Info Box
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(color: Colors.blue.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule, color: Colors.blue.shade700, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'ETA: $eta',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    riderName,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Location Pin
          Positioned(
            bottom: 40,
            right: 40,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.location_on, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusSection() {
    final statuses = [
      {'title': 'Order Placed', 'completed': true},
      {'title': 'Confirmed', 'completed': true},
      {'title': 'Preparing', 'completed': true},
      {'title': 'Out for Delivery', 'completed': true, 'current': true},
      {'title': 'Delivered', 'completed': false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Status',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Column(
          children: List.generate(statuses.length, (index) {
            final status = statuses[index];
            final isCompleted = status['completed'] as bool? ?? false;
            final isCurrent = status['current'] as bool? ?? false;
            final isLast = index == statuses.length - 1;

            return Column(
              children: [
                Row(
                  children: [
                    // Status Circle
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted || isCurrent
                            ? primaryOrange
                            : Colors.grey.shade300,
                      ),
                      child: Icon(
                        isCompleted ? Icons.check : Icons.circle,
                        color: isCompleted
                            ? Colors.white
                            : isCurrent
                                ? Colors.white
                                : Colors.grey,
                        size: isCompleted ? 24 : 20,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Status Title
                    Text(
                      status['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                        color: isCurrent ? primaryOrange : Colors.black,
                      ),
                    ),
                  ],
                ),

                // Connecting Line
                if (!isLast)
                  Padding(
                    padding: const EdgeInsets.only(left: 23, top: 8, bottom: 8),
                    child: Container(
                      width: 2,
                      height: 20,
                      color: isCompleted ? primaryOrange : Colors.grey.shade300,
                    ),
                  ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDeliveryInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery Info',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.phone, color: primaryOrange, size: 20),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rider Contact',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '0920-456-7890',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.location_on, color: primaryOrange, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivery Location',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          deliveryAddress,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
