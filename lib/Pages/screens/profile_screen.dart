import 'package:flutter/material.dart';

import 'package:food_delivery/services/auth_service.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),

      body: Center(child:ElevatedButton(onPressed: (){
        authService.logout(context);
      }, child: Icon(Icons.logout)) )

    );
  }
}
