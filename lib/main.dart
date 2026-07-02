import 'package:flutter/material.dart';
import 'package:food_delivery/Pages/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Pages/auth/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url:"https://xqlbbezpqglsokhcompx.supabase.co",
      publishableKey:"sb_publishable_OTeKJaRCRECMnw7xsGP9bw_nJwp9bET");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery app',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),
    );
  }
}




