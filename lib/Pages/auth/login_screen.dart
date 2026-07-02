import 'package:flutter/material.dart';
import 'package:food_delivery/Pages/auth/signup_screen.dart';

import '../../widgets/signup_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Image.asset(
                "assets/6343825.jpg",
                width: double.maxFinite,
                height: 500,
                fit: BoxFit.cover,
              ),

              TextField(
                controller:emailController ,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
              ),

              SizedBox(height: 20,),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.visibility),
                  ),

                ),
              ),
              SizedBox(height: 20,),

              SizedBox(width: double.maxFinite,
                  child: SignupButton(onTap: (){}, buttonText: "Login",),),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text("Don't have an account?",
                    style: TextStyle(color: Colors.black, fontSize: 18)
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => SignupScreen()),
                        );
                  },

                  child: Text("Create an account",
                      style: TextStyle(color: Colors.blue, fontSize: 18,
                      fontWeight: FontWeight.bold)),
                )
              ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
