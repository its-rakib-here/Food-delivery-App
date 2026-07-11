import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/Pages/screens/user_activity/favourite_screen.dart';
import 'package:food_delivery/core/models/product_model.dart';
import 'package:food_delivery/core/provider/cart_provider.dart';
import 'package:food_delivery/core/provider/model/cart_model.dart';
import 'package:food_delivery/utils/consts.dart';
import 'package:food_delivery/widgets/snack_bar.dart';
import 'package:readmore/readmore.dart';

class FoodDetailsScreen extends ConsumerStatefulWidget {
  final FoodModel products;


  const FoodDetailsScreen({super.key, required this.products});

  @override
  ConsumerState<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends ConsumerState<FoodDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appbarParts(context),
      extendBodyBehindAppBar: true,

      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: imageBackground,
            child: Image.asset(
              "assets/food-delivery/food pattern.png",
              color: imageBackgound2,
              repeat: ImageRepeat.repeatY,
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 90),
                  Center(
                    child: Hero(
                      tag: widget.products.imageCard,
                      child: Image.network(
                        widget.products.imageCard,
                        height: 320,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      height: 45,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Your action here

                                setState(() {
                                  quantity = quantity > 1 ? quantity - 1 : 1;
                                });
                              },
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                            SizedBox(width: 15),
                            Text(
                              quantity.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {
                                // Your action here

                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.products.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              widget.products.specialItems,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 12),

                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "\$",
                              style: TextStyle(color: red, fontSize: 18),
                            ),
                            TextSpan(
                              text: widget.products.price.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      foodInfo(
                        "assets/food-delivery/icon/star.png",
                        widget.products.rate.toString(),
                      ),
                      foodInfo(
                        "assets/food-delivery/icon/fire.png",
                        "${widget.products.rate.toString()}Kcal",
                      ),
                      foodInfo(
                        "assets/food-delivery/icon/time.png",
                        "${widget.products.rate.toString()}Min",
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  ReadMoreText(
                    desc,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                      color: Colors.black,
                    ),
                    trimLength: 110,
                    trimCollapsedText: "Ream More",
                    trimExpandedText: "Read Less",
                    colorClickableText: red,
                    moreStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: red,
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        elevation: 0,
        backgroundColor: Colors.transparent,
        label: MaterialButton(
          onPressed: ()  async {

            final cartModel = CartModel(
              productId: widget.products.id,
              productData: widget.products.toMap(),
              quantity: quantity,
              userId: supabase.auth.currentUser!.id,
            );

            await ref.read(cartProvider.notifier).addToCart(cartModel);

            showSnackbar(context, "Added to cart");

          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          height: 65,
          color: red,
          minWidth: 350,
          child: Text(
            "Add To Cart",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget foodInfo(String image, String value) {
    return Row(
      children: [
        Image.asset(image, width: 25),
        SizedBox(width: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  AppBar appbarParts(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leadingWidth: 80,
      forceMaterialTransparency: true,
      actions: [
        SizedBox(width: 27),

        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
        Spacer(),

        Container(
          height: 40,
          width: 40,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Icon(Icons.more_horiz_rounded, color: Colors.black, size: 18),
        ),
        SizedBox(width: 27),
      ],

      title: Text(widget.products.name),
    );
  }
}
