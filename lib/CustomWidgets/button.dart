import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  // final String text;
  final VoidCallback onPressed;
  final IconData icon;
  final double size;


  const CustomButtons({
    super.key,
    // required this.text,
    required this.onPressed,
    required this.icon,
    required this.size,
  }
      );

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: size, color: Colors.white, ),

    );
  }
}
