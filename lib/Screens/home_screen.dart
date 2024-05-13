import 'package:flutter/material.dart';
import 'package:weather_app_api/Models/weather_model.dart';
import 'package:weather_app_api/Screens/help_screen.dart';
import 'package:weather_app_api/repo.dart';

import '../CustomWidgets/button.dart';


class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final TextEditingController controller= TextEditingController();
  WeatherModel? weatherModel;

  @override
  Widget build(BuildContext context) {

    Future<void>_showErrorDialog() async{
      await showDialog(
          context: context,
          builder: (context)=>AlertDialog(
            title: Text("Error"),
            content: Text("Failed to load weather"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Ok")
              )
            ],
          ));
    }

    return FocusScope(
      child: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            backgroundColor: Color(0XBB153440),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0XBB153448),
              title: Padding(
                padding: const EdgeInsets.only(left: 50),
                child: const Text("Weather Forecasting",style: TextStyle(color: Colors.white),),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HelpScreenPage()));
                },
              ),
            ),


            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: Colors.white70,
                          style:  TextStyle(color: Colors.white70),
                          controller: controller,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear, size: 15, color: Colors.white70,),
                              onPressed: () {
                                controller.clear();
                              },
                            ),
                            labelText: "Search",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white)
                            ),
                          ),
                        ),
                      ),
                      CustomButtons(
                        onPressed: () async {
                          WeatherModel fetchedWeather = await Repo().getWeather(controller.text);
                          setState(() {
                            weatherModel = fetchedWeather; // Assigning fetched weather to weatherModel
                          });
                        }, icon: Icons.search, size: 22,
                      ),
                    ],
                  ),

                  Text("Lat: ${weatherModel?.location?.lat ?? "Null"}", style: TextStyle(color: Colors.white),) ,
                  if (weatherModel?.current?.condition?.icon != null) // Check if icon URL is available
                    Image.network(
                      'https:${weatherModel?.current?.condition?.icon}',
                      width: 64,
                      height: 64,
                    ),
                  Text("Current Temp: ${weatherModel?.current?.tempC ?? "Null"}",style: TextStyle(color: Colors.white),) ,
                  Text("Location: ${weatherModel?.location?.country ?? "Null"}",style: TextStyle(color: Colors.white),),
                  Text("Local Time: ${weatherModel?.location?.localtime ?? "Null"}",style: TextStyle(color: Colors.white),)
                ],
              ),
            )
        ),
      ),
    );
  }
}
