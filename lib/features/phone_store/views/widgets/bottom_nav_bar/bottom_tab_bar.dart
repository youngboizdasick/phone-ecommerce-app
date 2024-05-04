import 'package:flutter/material.dart';
import '../../screens/favorite/favorite_page.dart';
import '../../screens/home/home_page.dart';
import '../../screens/notification/notification_page.dart';
import '../../screens/user/user_page.dart';
import 'bottom_nav_bar.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBar();
}

class _BottomTabBar extends State<BottomTabBar> {
  int _selectedIndex = 0;

  //pages
  final List<Widget> _pages = [
    // Home page
    const HomePage(),

    // Favorite Page
    const FavoritePage(),

    // Notification Page
    const NotificationPage(),

    // User Page
    const UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        onTap: (index) => _navigateBottomNavBar(index),
        currentIndex: _selectedIndex,
      ),
      body: _pages[_selectedIndex],
    );
  }

  // navigate bottom nav bar
  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
