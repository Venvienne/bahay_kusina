// lib/screens/home_page.dart (Enhanced)

import 'package:flutter/material.dart';
import 'meal_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const Color primaryOrange = Color(0xFFFF6B00);
  static const Color secondaryOrange = Color(0xFFFF8C3B);
  static const Color accentRed = Color(0xFFE53935);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> mealPackages = [
    {
      'type': 'Breakfast',
      'title': 'Ultimate Breakfast Package',
      'vendor': "Nanay's Kitchen",
      'desc': 'Start your day right with a hearty Filipino breakfast',
      'price': 150,
      'left': 20,
      'image': 'assets/images/food_package_1.jpg',
    },
    {
      'type': 'Lunch',
      'title': 'Lunch Value Pack',
      'vendor': "Nanay's Kitchen",
      'desc': 'Complete lunch meal for the whole family',
      'price': 350,
      'left': 15,
      'image': 'assets/images/Food1.jpg',
    },
    {
      'type': 'Merienda',
      'title': 'Merienda Bundle',
      'vendor': "Lola's Lutong Bahay",
      'desc': 'Perfect afternoon snacks for the family',
      'price': 180,
      'left': 8,
      'image': 'assets/images/Food1.jpg',
    },
    {
      'type': 'Dinner',
      'title': 'Family Dinner Feast',
      'vendor': "Ate's Specialties",
      'desc': 'A satisfying meal for four, ready to serve',
      'price': 499,
      'left': 12,
      'image': 'assets/images/Food1.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const List<String> categories = [
      'All',
      'Breakfast',
      'Lunch',
      'Dinner',
      'Merienda',
      'Dessert'
    ];

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8), // Subtle background contrast
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: true,
                pinned: true,
                snap: true,
                // --- REMOVED BACK ICON LOGIC ---
                automaticallyImplyLeading: false, 
                leading: null, 
                // -------------------------------
                elevation: 0,
                backgroundColor: HomePage.primaryOrange,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [HomePage.primaryOrange, HomePage.secondaryOrange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 10,
                          left: 20,
                          right: 20,
                          child: _buildHeaderContent(),
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(110.0), 
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                        child: _buildSearchBar(),
                      ),
                      TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.transparent, // Hide default underline
                        dividerColor: Colors.transparent,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white.withOpacity(0.7),
                        tabAlignment: TabAlignment.start,
                        padding: const EdgeInsets.only(left: 15, bottom: 8),
                        tabs: categories.map((name) => Tab(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20.0), // Pill style
                              border: Border.all(color: Colors.white.withOpacity(0.1)),
                            ),
                            child: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
                          ),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories.map((category) {
              final filteredPackages = category == 'All'
                  ? mealPackages
                  : mealPackages.where((meal) => meal['type'] == category).toList();

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                itemCount: filteredPackages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Available Packages',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            'From local home-based vendors in your area',
                            style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  final meal = filteredPackages[index - 1];
                  return MealCard(
                    type: meal['type'],
                    title: meal['title'],
                    vendor: meal['vendor'],
                    desc: meal['desc'],
                    price: meal['price'],
                    left: meal['left'],
                    imageUrl: meal['image'],
                  );
                },
              );
            }).toList(),
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(context),
      ),
    );
  }

  Widget _buildHeaderContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24, width: 2),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/bahay_kusina_logo.png',
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.restaurant, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "BahayKusina",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Home-Cooked Meals",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            _buildHeaderIcon(Icons.notifications_none, true),
            const SizedBox(width: 8),
            _buildHeaderIcon(Icons.shopping_bag_outlined, false),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderIcon(IconData icon, bool hasBadge) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white, size: 26),
          onPressed: () {},
        ),
        if (hasBadge)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: HomePage.accentRed,
                shape: BoxShape.circle,
              ),
            ),
          )
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search your favorite home-cooked meal...",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search_rounded, color: HomePage.primaryOrange),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      elevation: 20,
      selectedItemColor: HomePage.primaryOrange,
      unselectedItemColor: Colors.grey[400],
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
      ],
      onTap: (index) {},
    );
  }
}