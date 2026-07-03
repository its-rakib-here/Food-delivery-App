import 'package:flutter/material.dart';

import 'package:food_delivery/services/auth_service.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProfileScreen> {
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
