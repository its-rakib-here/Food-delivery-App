import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Pages/screens/profile_screen.dart';
import 'package:food_delivery/Pages/screens/user_activity/favourite_screen.dart';
import 'package:food_delivery/utils/consts.dart';
import 'package:iconsax/iconsax.dart';

import 'food_app_home_screen.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    const FoodAppHomeScreen(),
    const FavouriteScreen(),
     ProfileScreen(),
    const Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],

      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 85,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildNavItems(Iconsax.home_15, 0),
                ),
                Expanded(
                  child: _buildNavItems(Iconsax.heart, 1),
                ),

                /// Space for Search Button
                const SizedBox(width: 70),

                Expanded(
                  child: _buildNavItems(Icons.person_outline, 2),
                ),

                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      _buildNavItems(Iconsax.shopping_cart, 3),

                      Positioned(
                        top: 10,
                        right: 18,
                        child: CircleAvatar(
                          radius: 9,
                          backgroundColor: red,
                          child: const Text(
                            "0",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Floating Search Button
          Positioned(
            top: -28,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: red.withOpacity(.35),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  CupertinoIcons.search,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItems(IconData icon, int index) {
    final bool isSelected = currentIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: isSelected ? red : Colors.grey,
          ),

          const SizedBox(height: 4),

          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isSelected ? red : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}