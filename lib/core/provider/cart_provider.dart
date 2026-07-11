import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/core/provider/model/cart_model.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final cartProvider = NotifierProvider<cartNotifier, List<CartModel>>(
  cartNotifier.new,
);

class cartNotifier extends Notifier<List<CartModel>> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  @override
  List<CartModel> build() {
    Future.microtask(() => loadCart());

    return [];
  }

  Future<void> addToCart(CartModel cartModel) async {
    await _supabaseClient.from('cart').insert(cartModel.toMap());

    final index = state.indexWhere(
      (item) => item.productId == cartModel.productId,
    );

    if (index != -1) {
      state[index].quantity++;
      state = [...state];
    } else {
      state = [...state, cartModel];
    }
  }

  void increaseQuantity(String productId) {
    final index = state.indexWhere((item) => item.productId == productId);
    if (index != -1) return;

    state[index].quantity++;
    state = [...state];
  }

  void decreaseQuantity(String ProductdId) {
    final index = state.indexWhere((item) => item.productId == ProductdId);
    if (index == -1) return;

    if (state[index].quantity > 1) {
      state[index].quantity--;
      state = [...state];
    } else {
      removeCart(state[index]);
    }
  }

  Future<void> removeCart(CartModel cartModel) async {
    await _supabaseClient.from('cart').delete().eq('id', cartModel.id);

    state = state
        .where((item) => item.productId != cartModel.productId)
        .toList();
  }

  double get TotalPrice {
    return state.fold(
      0.0,
      (total, item) => total + item.productData['price'] * item.quantity,
    );
  }

  int get totallItems {
    return state.fold(0, (total, item) => total + item.quantity);
  }

  Future<void> loadCart() async {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) return;

    try {
      final response = await _supabaseClient
          .from('cart')
          .select()
          .eq('userId', userId);
      state = response
          .map<CartModel>((item) => CartModel.fromMap(item))
          .toList();
    } catch (e) {
      print("Error loading cart: $e");
    }
  }
}
