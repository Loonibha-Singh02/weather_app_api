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
      // child: Text(text, style: TextStyle(color: Colors.black),),
      style: ElevatedButton.styleFrom(
          elevation: 0,
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //     side: BorderSide(
          //         width: 1
          //     )
          // )
      ),
      icon: Icon(icon, size: size, color: Colors.white, ),

    );
  }
}
