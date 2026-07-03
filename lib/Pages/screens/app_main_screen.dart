import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/consts.dart';
import 'package:iconsax/iconsax.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItems(Iconsax.home_15, 'A', 0),
            SizedBox(width: 10),
            _buildNavItems(Iconsax.heart, 'B', 1),
            SizedBox(width: 10),

            _buildNavItems(Icons.person_outline, 'C', 2),
            SizedBox(width: 10),

            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildNavItems(Iconsax.shopping_cart, 'D', 3),
                Positioned(
                  top: 16,
                  right: -7,
                  //we will make this cart item dynamic letter
                  child: CircleAvatar(
                    backgroundColor: red,
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                    right: 155,
                    top:-25,
                    child: CircleAvatar(backgroundColor: red,

                  radius: 35,
                 child: Icon(
                   CupertinoIcons.search,
                   size: 35,
                   color: Colors.white,
                 )
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItems(IconData icon, String label, int index) {
    int currentIndex = 0;
    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 28,
            color: currentIndex == index ? red : Colors.grey,
          ),
          SizedBox(height: 3),
          CircleAvatar(
            radius: 3,
            backgroundColor: currentIndex == index ? red : Colors.transparent,
          ),
          // Text(
          //   label,
          //   style: TextStyle(
          //     color: _currentIndex == index ? red : Colors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }
}
