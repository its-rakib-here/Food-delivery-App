import 'package:flutter/material.dart';

import '../../widgets/signup_button.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                "assets/6333204.jpg",
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

              SizedBox(width: double.maxFinite, child: SignupButton(onTap: (){}, buttonText: "Sign Up",),),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text("Already have an account?",
                style: TextStyle(color: Colors.black, fontSize: 18)
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => LoginScreen()));
                  },

                  child: Text("Login here",
                  style: TextStyle(color: Colors.blue, fontSize: 18)),
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
