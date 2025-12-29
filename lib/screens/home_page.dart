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
  // 1. Add a controller and a search string state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

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
  void initState() {
    super.initState();
    // 2. Listen to search changes
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<String> categories = ['All', 'Breakfast', 'Lunch', 'Dinner', 'Merienda', 'Dessert'];

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: true,
                pinned: true,
                snap: true,
                automaticallyImplyLeading: false,
                leading: null,
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
                        child: _buildSearchBar(), // Controller is linked here
                      ),
                      TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white.withOpacity(0.7),
                        tabAlignment: TabAlignment.start,
                        padding: const EdgeInsets.only(left: 15, bottom: 8),
                        tabs: categories.map((name) => _buildTabPill(name)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories.map((category) {
              // 3. COMBINED FILTERING LOGIC
              final filteredPackages = mealPackages.where((meal) {
                final matchesCategory = (category == 'All' || meal['type'] == category);
                final matchesSearch = meal['title'].toString().toLowerCase().contains(_searchQuery) ||
                                     meal['vendor'].toString().toLowerCase().contains(_searchQuery);
                return matchesCategory && matchesSearch;
              }).toList();

              return _buildPackageList(filteredPackages, category);
            }).toList(),
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(context),
      ),
    );
  }

  Widget _buildTabPill(String name) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildPackageList(List<Map<String, dynamic>> items, String category) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text("No packages found", 
              style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w500)),
            const Text("Try searching for something else", 
              style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 5, left: 5),
            child: Text(
              _searchQuery.isEmpty ? 'Available $category Packages' : 'Results for "$_searchQuery"',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          );
        }
        final meal = items[index - 1];
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
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: TextField(
        controller: _searchController, // Linked the controller here
        decoration: InputDecoration(
          hintText: "Search meals or vendors...",
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: const Icon(Icons.search_rounded, color: HomePage.primaryOrange),
          suffixIcon: _searchQuery.isNotEmpty 
            ? IconButton(
                icon: const Icon(Icons.clear_rounded, color: Colors.grey),
                onPressed: () => _searchController.clear(),
              ) 
            : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  // ... (Header and BottomNavBar methods remain the same)
  Widget _buildHeaderContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(Icons.restaurant_menu, color: HomePage.primaryOrange, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("BahayKusina", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                Text("Meal Packages", style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ],
        ),
        IconButton(icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white), onPressed: () {}),
      ],
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: HomePage.primaryOrange,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
      ],
    );
  }
}