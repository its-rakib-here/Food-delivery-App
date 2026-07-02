import 'package:flutter/material.dart';
import '../../services/auth_serice.dart';

import '../../widgets/signup_button.dart';
import '../../widgets/snack_bar.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoding = false;
  bool isPasswordHidden = true;

  final AuthSerice _authSerice = AuthSerice();

  void _signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackbar(context, "Please fill in all fields");
      return;
    }

    if (!email.contains('@')) {
      showSnackbar(context, "Please enter a valid email");
      return;
    }

    setState(() {
      isLoding = true;
    });

    final result = await _authSerice.signup(email, password);

    if (result == null) {
      setState(() {
        isLoding = false;
      });
      showSnackbar(context, "Sign up successful");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    } else {
      setState(() {
        isLoding = false;
      });
      showSnackbar(context, "Signup Failed: $result");
    }
  }

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
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: isPasswordHidden,
              ),
              SizedBox(height: 20),

              isLoding
                  ? Center(child:  const CircularProgressIndicator(),)
                  :
              SizedBox(

                width: double.maxFinite,
                child: SignupButton(onTap: () {
                  _signUp();

                }, buttonText: "Sign Up"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },

                    child: Text(
                      "Login here",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
