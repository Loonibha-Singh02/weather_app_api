import 'package:flutter/material.dart';

class CustomElevButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;

  const CustomElevButton({super.key, required this.text, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressed,
        child: Text(text,
        style: TextStyle(
          color: Colors.white
        ),
        ),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            minimumSize: const Size(180, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(
                color: Colors.white
              )
            ),
        ),
    );
  }
}
