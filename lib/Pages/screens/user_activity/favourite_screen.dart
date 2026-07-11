import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/core/models/on_bording_model.dart';
import 'package:food_delivery/core/models/product_model.dart';
import 'package:food_delivery/core/provider/favourite_provider.dart';
import 'package:food_delivery/widgets/snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class FavouriteScreen extends ConsumerStatefulWidget {
  const FavouriteScreen({super.key});

  @override
 ConsumerState <FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends ConsumerState<FavouriteScreen> {


  @override
  Widget build(BuildContext context) {

    final userId = supabase.auth.currentUser?.id;
    final favourites= ref.watch(favouriteProvider);
    final notifier = ref.read(favouriteProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Favourite", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),

      body: userId == null
          ? const Center(
              child: Text("Please login first to view your favourite items"),
            )
          : StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase
                  .from("favourite")
                  .stream(primaryKey: ['id'])
                  .eq("user_id", userId!)
                  .map((data) => data.cast<Map<String, dynamic>>()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No favourites yet"));
                }

                final favouritesItem = snapshot.data!;

                return FutureBuilder<List<FoodModel>>(
                  future: _fetchProducts(favouritesItem),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No products found"));
                    }

                    final products = snapshot.data!;

                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final FoodModel items = products[index];

                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 110,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(items.imageCard),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 20,
                                            ),
                                            child: Text(
                                              items.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Text(items.category),
                                          Text(
                                            "\$${items.price}.00",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              right: 10,
                              child: GestureDetector(
                                onTap: () async {
                                  // Delete favourite
                                  await notifier.removeFavourite(items);

                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }

  Future<List<FoodModel>> _fetchProducts(
      List<Map<String, dynamic>> favourites,
      ) async {
    final List<String> productIds = favourites
        .map((fav) => fav["product_id"] as String)
        .toList();

    if (productIds.isEmpty) {
      return [];
    }

    try {
      final response = await supabase
          .from("food_items")
          .select()
          .inFilter("id", productIds);

      debugPrint("Response: $response");

      return (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("Error fetching products: $e");
      return [];
    }
  }
}
