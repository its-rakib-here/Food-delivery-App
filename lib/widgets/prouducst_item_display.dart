import 'package:flutter/material.dart';
import 'package:food_delivery/Pages/screens/food_details_screen.dart';
import 'package:food_delivery/core/models/product_model.dart';

class ProuducstItemDisplay extends StatefulWidget {
  final FoodModel foodModel;

  const ProuducstItemDisplay({super.key, required this.foodModel});

  @override
  State<ProuducstItemDisplay> createState() => _ProuducstItemDisplayState();
}

class _ProuducstItemDisplayState extends State<ProuducstItemDisplay> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (_, __, ___) =>
                FoodDetailsScreen(products: widget.foodModel),
          ),
        );
      },
      child: SizedBox(
        width: size.width * .5,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 20,
              child: Container(
                width: size.width * .5,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(15),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: SizedBox(
                width: size.width * .5,
                child: Column(
                  children: [
                    Hero(
                      tag: widget.foodModel.name,
                      child: ClipOval(
                        child: Image.network(
                          widget.foodModel.imageCard,
                          width: 105,
                          height: 105,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      height: 44,
                      child: Text(
                        widget.foodModel.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      widget.foodModel.specialItems,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      "\$${widget.foodModel.price}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 10,
              right: 10,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.red.shade100,
                child: Image.asset(
                  "assets/food-delivery/icon/fire.png",
                  width: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
