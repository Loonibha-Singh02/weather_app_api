import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const CustomCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor,),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 18,
            ),
            ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
          ],
        ),
      ),
    );
  }
}
