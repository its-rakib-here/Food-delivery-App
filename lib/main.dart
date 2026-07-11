import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/Pages/screens//profile_screen.dart';
import 'package:food_delivery/Pages/auth/login_screen.dart';
import 'package:food_delivery/Pages/screens/app_main_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Pages/auth/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['SUPABASE_PUBLISHABLE_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Food Delivery app',
      
        debugShowCheckedModeBanner: false,
        home: Authcheck(),
      
        // theme: ThemeData(
        //
        //   colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        // ),
      ),
    );
  }
}

class Authcheck extends StatelessWidget {
  Authcheck({super.key});

  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final session = supabase.auth.currentSession;

        if (session == null) {
          return const LoginScreen();
        }

        return const AppMainScreen();
      },
    );
  }
}

