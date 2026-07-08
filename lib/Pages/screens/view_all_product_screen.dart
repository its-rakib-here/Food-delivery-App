import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/product_model.dart';

class ViewAllProductScreen extends StatefulWidget {
  const ViewAllProductScreen({super.key});

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

  Future<void> fetchProducts() async

  {
    try {
      final response = await Supabase.instance.client
          .from('food_items')
          .select();
      final data = response as List;
      setState(() {
        products=data.map((json)=> FoodModel.fromJson(json)).toList();
        isLoading =false;

      });

    }
    catch(e)
    {
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
        title: Text("All Products"),
      ),

      body: isLoading?Center(child: CircularProgressIndicator(),),

    );
  }
}
