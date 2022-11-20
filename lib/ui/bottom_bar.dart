import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import './screens.dart';


class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  final List _pages = [
    const HomeScreen(),
    const ProductScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];
  
  void _onItemTapped(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [ BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            color: Color(0x4E0C9869)
          )]
        ),
        child: GNav(
          gap: 8,
          selectedIndex: 0,
          tabBackgroundColor: const Color(0x800C9869),
          padding: const EdgeInsets.all(10),
          duration: const Duration(milliseconds: 300),
          onTabChange: _onItemTapped,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: "Home",
            ),
            GButton(
              icon: Icons.coffee_outlined,
              text: "Product",
            ),
            GButton(
              icon: Icons.local_atm_outlined,
              text: "Order",
            ),
            GButton(
              icon: Icons.assignment_ind_outlined,
              text: "Profile"
            ),
          ],
        ),
      )    
    );
  }
}