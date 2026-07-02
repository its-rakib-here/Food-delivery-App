import 'package:flutter/material.dart';
class SignupButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final Color?color;

  const SignupButton({super.key
  , required this.onTap,
  required this.buttonText,
  this.color=Colors.blueAccent,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      )
    );
  }
}
