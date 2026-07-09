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
    return [];
  }

  List<String> _favouriteIds = [];

  String? get userId => _supabase.auth.currentUser?.id;

  Future<void> addFavourite(FoodModel food) async {
    if (userId == null) return;
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

    state = state.where((e) => e.name != food.name).toList();
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
    return state.any((e) => e.name == food.name);
  }

  void clearFavourite() {
    state = [];
  }

  Future<void> loadFavourites() async {
    if (userId == null) return;

    try {
      final response = await _supabase
          .from("favourites")
          .select("product_it")
          .eq("user_id", userId!);

      _favouriteIds = response.map((e) => e["product_it"] as String).toList();
    } catch (e) {
      print("Error loading favourites: $e");
    }
  }
}
