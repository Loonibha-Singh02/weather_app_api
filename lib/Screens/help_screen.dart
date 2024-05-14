import"package:flutter/material.dart";
import "package:weather_app_api/Screens/home_screen.dart";

class HelpScreenPage extends StatefulWidget {
  const HelpScreenPage({super.key});

  @override
  State<HelpScreenPage> createState() => _HelpScreenPageState();
}

class _HelpScreenPageState extends State<HelpScreenPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(seconds: 5),()
    {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context)=>const HomeScreenPage())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xBBA3D8FF),
      body: Container(
        padding: const EdgeInsets.only(right: 10,left: 10,top: 20,bottom: 20),
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.asset('assets/images/frame2.png',
                  fit: BoxFit.fill,)
            ),
            const Positioned(
                top: 300,
                left: 90,
                child: Text('We show weather for you.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                )
            ),
            Positioned(
                top: 400,
                left: 140,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreenPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.black,
                      minimumSize: const Size(100, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),),
                    child: const Text('Skip',
                      style: TextStyle(
                          color: Colors.white
                      ),)
                )
            )
          ],
        ),
      ),
    );
  }
}
