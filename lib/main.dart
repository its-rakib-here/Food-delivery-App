import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/Pages/screens//profile_screen.dart';
import 'package:food_delivery/Pages/auth/login_screen.dart';
import 'package:food_delivery/Pages/screens/app_main_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Pages/auth/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://xqlbbezpqglsokhcompx.supabase.co",
    publishableKey: "sb_publishable_OTeKJaRCRECMnw7xsGP9bw_nJwp9bET",
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
  final supabae = Supabase.instance.client;
  Authcheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabae.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabae.auth.currentSession;

        if (session != null) {
          return AppMainScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
