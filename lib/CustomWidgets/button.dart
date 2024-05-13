import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButtons({
    super.key,
    required this.text,
    required this.onPressed,

  }
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.black),),
      style: ElevatedButton.styleFrom(
          elevation: 0,

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  width: 1
              )
          )
      ),
    );
  }
}
