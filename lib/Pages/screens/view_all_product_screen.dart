import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/models/product_model.dart';
import '../../widgets/prouducst_item_display.dart';

class ViewAllProductScreen extends StatefulWidget {

  @override
  State<ViewAllProductScreen> createState() => _ViewAllProductScreenState();
}

class _ViewAllProductScreenState extends State<ViewAllProductScreen> {
  final supabase = Supabase.instance.client;
  List<FoodModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await Supabase.instance.client
          .from('food_items')
          .select();
      final data = response as List;
      setState(() {
        products = data.map((json) => FoodModel.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text("All Products"),
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
          itemCount: products.length,
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2,
            childAspectRatio: 0.72,
              crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index){
            return ProuducstItemDisplay(foodModel: products[index]);
          }),


    );
  }
}
