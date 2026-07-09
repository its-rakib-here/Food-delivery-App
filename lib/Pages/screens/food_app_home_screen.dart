import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Pages/screens/view_all_product_screen.dart';
import 'package:food_delivery/core/models/product_model.dart';
import 'package:food_delivery/utils/consts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../models/categories_model.dart';
import '../../core/models/categories_model.dart';
import '../../widgets/prouducst_item_display.dart';

class FoodAppHomeScreen extends StatefulWidget {
  const FoodAppHomeScreen({super.key});

  @override
  State<FoodAppHomeScreen> createState() => _FoodAppHomeScreenState();
}

class _FoodAppHomeScreenState extends State<FoodAppHomeScreen> {
  late Future<List<CategoryModel>> futureCategories = fetchCatagories();
  late Future<List<FoodModel>> futureProducts = Future.value([]);
  List<CategoryModel> categories = [];
  String? selectedCategory;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _initializeData();
  }

  Future<List<FoodModel>> fetchProduct(String category) async {
    print("Selected category: $category");

    try {
      final response = await Supabase.instance.client
          .from("food_items")
          .select()
          .eq("category", category);

      print(response); // Prints the entire response

      for (var item in response) {
        print("Special Item: ${item['specialItems']}");
      }

      return (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
    } catch (e) {
      print("Error fetching category: $e");
      return [];
    }
  }

  void _initializeData() async {
    try {
      final categories = await futureCategories;
      if (categories.isNotEmpty) {
        setState(() {
          this.categories = categories;
          selectedCategory = categories[0].name;
          //fetch products
          futureProducts = fetchProduct(selectedCategory!);
        });
      }
    } catch (e) {
      print("Error initializing data: $e");
    }
  }

  //fetch category

  Future<List<CategoryModel>> fetchCatagories() async {
    try {
      final response = await Supabase.instance.client
          .from("category_item")
          .select();
      return (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      print("Error fetching category : $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: appbarParts(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBanner(),
                SizedBox(height: 25),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 20),

                _buildCategoriesList(),

                SizedBox(height: 30),

                viewAll(),
                SizedBox(height: 30),

                _buildProudctSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProudctSection() {
    return SizedBox(
      height: 260,
      child: FutureBuilder<List<FoodModel>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 25 : 10,
                  right: index == products.length - 1 ? 25 : 10,
                ),
                child: ProuducstItemDisplay(foodModel: product),
              );
            },
          );
        },
      ),
    );
  }

  Padding viewAll() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Popular Now",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: ((_) => ViewAllProductScreen())),
              );
            },

            child: Row(
              children: [
                Text("View All", style: TextStyle(color: orange)),
                SizedBox(width: 5),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList() {
    return FutureBuilder<List<CategoryModel>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final categories = snapshot.data!;

        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              print("Image URL: ${category.image}");
              // Build your category item here
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                child: GestureDetector(
                  onTap: () {
                    handleCategoryTap(category.name);
                    setState(() {
                      selectedCategory = category.name;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selectedCategory == category.name ? red : grey1,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: selectedCategory == category.name
                                ? Colors.white
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            category.image,
                            width: 22,
                            height: 22,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.fastfood, size: 20);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: selectedCategory == category.name
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  AppBar appbarParts() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        SizedBox(width: 25),
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: grey1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset("assets/food-delivery/icon/dash.png"),
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 18, color: red),
            SizedBox(width: 5),
            Text(
              "Dhaka,Bangladesh",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5),
            Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: orange),
          ],
        ),
        Spacer(),
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: grey1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset("assets/food-delivery/profile.png"),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  void handleCategoryTap(String category) {
    if (selectedCategory == category) {
      return;
    }
    setState(() {
      selectedCategory = category;
      futureProducts = fetchProduct(category);
    });
  }

  Container appBanner() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: imageBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            const TextSpan(
                              text: "The Fastest In Delivery",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: " Food",
                              style: TextStyle(color: red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 9,
                        ),
                        child: const Text(
                          " Order Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset("assets/food-delivery/courier.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
