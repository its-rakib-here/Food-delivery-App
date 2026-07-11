import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/core/provider/model/cart_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final cartProvider =
NotifierProvider<CartNotifier, List<CartModel>>(
  CartNotifier.new,
);

class CartNotifier extends Notifier<List<CartModel>> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  @override
  List<CartModel> build() {
    Future.microtask(() => loadCart());
    return [];
  }

  /// Load Cart
  Future<void> loadCart() async {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) return;

    try {
      final response = await _supabaseClient
          .from('cart')
          .select()
          .eq('user_id', userId);

      state = response
          .map<CartModel>((e) => CartModel.fromMap(e))
          .toList();
    } catch (e) {
      print("Load Cart Error : $e");
    }
  }

  /// Add To Cart
  Future<void> addToCart(CartModel cartModel) async {
    final index = state.indexWhere(
          (item) => item.productId == cartModel.productId,
    );

    if (index != -1) {
      final updatedQuantity = state[index].quantity + cartModel.quantity;

      await _supabaseClient
          .from('cart')
          .update({'quantity': updatedQuantity})
          .eq('id', state[index].id!);

      state[index].quantity = updatedQuantity;
      state = [...state];
    } else {
      final response = await _supabaseClient
          .from('cart')
          .insert(cartModel.toMap())
          .select()
          .single();

      state = [...state, CartModel.fromMap(response)];
    }
  }

  /// Increase Quantity
  Future<void> increaseQuantity(CartModel cartModel) async {
    final index = state.indexWhere(
          (item) => item.productId == cartModel.productId,
    );

    if (index == -1) return;

    final updatedQuantity = state[index].quantity + 1;

    await _supabaseClient
        .from('cart')
        .update({'quantity': updatedQuantity})
        .eq('id', state[index].id!);

    state[index].quantity = updatedQuantity;
    state = [...state];
  }

  /// Decrease Quantity
  Future<void> decreaseQuantity(CartModel cartModel) async {
    final index = state.indexWhere(
          (item) => item.productId == cartModel.productId,
    );

    if (index == -1) return;

    if (state[index].quantity > 1) {
      final updatedQuantity = state[index].quantity - 1;

      await _supabaseClient
          .from('cart')
          .update({'quantity': updatedQuantity})
          .eq('id', state[index].id!);

      state[index].quantity = updatedQuantity;
      state = [...state];
    } else {
      await removeCart(cartModel);
    }
  }

  /// Remove Item
  Future<void> removeCart(CartModel cartModel) async {
    if (cartModel.id == null) return;

    await _supabaseClient
        .from('cart')
        .delete()
        .eq('id', cartModel.id!);

    state = state
        .where((item) => item.id != cartModel.id)
        .toList();
  }

  /// Clear Cart
  Future<void> clearCart() async {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) return;

    await _supabaseClient
        .from('cart')
        .delete()
        .eq('user_id', userId);

    state = [];
  }

  /// Total Items
  int get totalItems {
    return state.fold(
      0,
          (total, item) => total + item.quantity,
    );
  }

  /// Total Price
  double get totalPrice {
    return state.fold(
      0.0,
          (total, item) =>
      total +
          ((item.productData['price'] as num).toDouble() *
              item.quantity),
    );
  }

  /// Check Product Exists
  bool isInCart(String productId) {
    return state.any(
          (item) => item.productId == productId,
    );
  }
}