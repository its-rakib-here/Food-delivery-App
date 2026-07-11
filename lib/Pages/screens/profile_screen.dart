import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/core/provider/favourite_provider.dart';
import 'package:food_delivery/services/auth_service.dart';

AuthService authService = AuthService();

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                authService.logout(context);
                ref.invalidate(favouriteProvider);
              },
              child: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }
}
