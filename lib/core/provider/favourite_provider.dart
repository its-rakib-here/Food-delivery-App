import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

final favouriteProvider = NotifierProvider<FavouriteNotifier, List<FoodModel>>(
  FavouriteNotifier.new,
);

class FavouriteNotifier extends Notifier<List<FoodModel>> {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  List<FoodModel> build() {
    Future.microtask(() => loadFavourites());
    return [];
  }

  List<String> _favouriteIds = [];

  String? get userId => _supabase.auth.currentUser?.id;

  Future<void> addFavourite(FoodModel food) async {
    if (userId == null) return;

    if (isFavourite(food)) return;

    await _supabase.from("favourite").insert({
      "user_id": userId,
      "product_id": food.id,
    });

    state = [...state, food];
  }

  Future<void> removeFavourite(FoodModel food) async {
    if (userId == null) return;

    await _supabase
        .from("favourite")
        .delete()
        .eq("user_id", userId!)
        .eq("product_id", food.id);

    state = state.where((e) => e.id != food.id).toList();
  }

  /// Toggle Favourite
  Future<void> toggleFavourite(FoodModel food) async {
    if (isFavourite(food)) {
      await removeFavourite(food);
    } else {
      await addFavourite(food);
    }
  }

  bool isFavourite(FoodModel food) {
    return state.any((e) => e.id == food.id);
  }

  void clearFavourite() {
    state = [];
  }

  Future<void> loadFavourites() async {
    if (userId == null) return;

    try {
      final favouriteResponse = await _supabase
          .from("favourite")
          .select("product_id")
          .eq("user_id", userId!);

      final productIds = favouriteResponse
          .map((e) => e["product_id"] as String)
          .toList();

      if (productIds.isEmpty) {
        state = [];
        return;
      }

      final products = await _supabase
          .from("food_items")
          .select()
          .inFilter("id", productIds);

      state = products
          .map<FoodModel>((e) => FoodModel.fromJson(e))
          .toList();
    } catch (e) {
      print("Load favourite error: $e");
    }
  }
}
