import 'package:flutter/material.dart';
import 'package:food_delivery/Pages/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSerice {
  final supabase = Supabase.instance.client;

  //sign up function

  Future<String?> signup(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return null;
      }
      return "An unknown error occured";
    } catch (e) {
      return "Error: $e";
    }
  }

  //login

  Future<String?> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return null;
      }
      return "Invalid email or password";
    } catch (e) {
      return "Error: $e";
    }
  }

  //logout
  Future<void> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();

      if (!context.mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    } catch (e) {
      print("Error logging out: $e");
    }
  }


}
