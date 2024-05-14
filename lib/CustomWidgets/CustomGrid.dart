import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGridView extends StatelessWidget {
  final List<String> texts;
  final List<IconData> icons;
  final  List<String> title;

  CustomGridView({required this.texts, required this.icons, required this.title});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: texts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.8
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                color: Color(0xBBB3C8CF),
                borderRadius: BorderRadius.circular(30),
          ),
          child: GridTile(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          icons[index],
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10,),
                        Text(title[index], style: GoogleFonts.handlee(
                          fontSize: 12,
                          color: Colors.white, // You can customize the color here if needed
                        ),)
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      texts[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          )
          ),
        );
      },
    );
  }
}
