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
            bottom: 35,
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
          Container(
            width: size.width * 0.5,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.network(
                    widget.foodModel.imageCard,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    widget.foodModel.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  widget.foodModel.specialItems,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.2,
                  ),
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [TextSpan(text: "\$${widget.foodModel.price}")],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
