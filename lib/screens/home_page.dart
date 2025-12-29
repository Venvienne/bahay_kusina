// lib/screens/home_page.dart (Updated)

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
  // ... mealPackages list remains the same ...
  final List<Map<String, dynamic>> mealPackages = [
    {
      'type': 'Breakfast',
      'title': 'Ultimate Breakfast Package',
      'vendor': "Nanay's Kitchen",
      'desc': 'Start your day right with a hearty Filipino breakfast',
      'price': 150,
      'left': 20,
      'image': 'assets/images/Food1.jpg',
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
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                // Use a larger height to accommodate content above the search bar
                expandedHeight: 200.0, 
                floating: true,
                pinned: true,
                snap: true,
                backgroundColor: HomePage.primaryOrange,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  // --- FIX 2: Removed titlePadding and title widget for custom header placement ---
                  // title: _buildHeaderContent(), 
                  // titlePadding: const EdgeInsets.only(left: 20, bottom: 50, right: 20),
                  
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [HomePage.primaryOrange, HomePage.secondaryOrange],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    // --- FIX 3: Placing custom header content in the background Stack ---
                    child: Stack(
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 5,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: _buildHeaderContent(),
                          ),
                        ),
                      ],
                    ),
                    // -----------------------------------------------------------------------------
                  ),
                ),
                bottom: PreferredSize(
                  // Use a preferred size that exactly fits the search bar and TabBar
                  preferredSize: const Size.fromHeight(100.0), 
                  child: Column(
                    children: [
                      // --- FIX 1: Increased vertical padding for search bar visibility ---
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                        child: _buildSearchBar(),
                      ),
                      // --------------------------------------------------------------------
                      TabBar(
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3.0,
                        indicatorColor: Colors.white,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        tabs: categories
                            .map((name) => Tab(text: name))
                            .toList(),
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
                  : mealPackages
                      .where((meal) => meal['type'] == category)
                      .toList();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 10, bottom: 5),
                      child: Text(
                        'Available Packages',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey.shade700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        'From local home-based vendors',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ),
                    Expanded(
                      child: filteredPackages.isEmpty
                          ? Center(child: Text('No $category packages available.'))
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: filteredPackages.length,
                              itemBuilder: (context, index) {
                                final meal = filteredPackages[index];
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
                            ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(context),
      ),
    );
  }

  // --- No changes needed here, as content is moved and positioned in SliverAppBar's background ---
  Widget _buildHeaderContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    final dynamicLogoSize = screenWidth * 0.18;
    final dynamicPadding = dynamicLogoSize * 0.15;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(dynamicPadding),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/bahay_kusina_logo.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "BahayKusina",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Meal Packages",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none,
                      color: Colors.white),
                  onPressed: () {},
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: HomePage.accentRed,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                  ),
                )
              ],
            ),
            IconButton(
              icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
  // --------------------------------------------------------------------------------------------------
  
  // _buildSearchBar and _buildBottomNavBar remain the same
  Widget _buildSearchBar() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search meal packages...",
          prefixIcon: Icon(Icons.search, color: HomePage.primaryOrange),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: HomePage.primaryOrange,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // Navigation logic for bottom bar goes here
      },
    );
  }
}