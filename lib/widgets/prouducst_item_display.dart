import 'package:flutter/material.dart';
import 'package:food_delivery/models/product_model.dart';

class ProuducstItemDisplay extends StatefulWidget {
  final FoodModel foodModel;

  const ProuducstItemDisplay({super.key, required this.foodModel});

  @override
  State<ProuducstItemDisplay> createState() => _ProuducstItemDisplayState();
}

class _ProuducstItemDisplayState extends State<ProuducstItemDisplay> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},

      child: Stack(
        alignment: Alignment.bottomCenter,

        children: [
          Positioned(
            child: Container(
              height: 180,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    spreadRadius: 10,
                    blurRadius: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
