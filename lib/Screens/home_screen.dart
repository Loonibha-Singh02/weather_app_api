import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_api/Models/weather_model.dart';
import 'package:weather_app_api/Screens/help_screen.dart';
import 'package:weather_app_api/repo.dart';
import '../CustomWidgets/CustomGrid.dart';
import '../CustomWidgets/CustomTempText.dart';
import '../CustomWidgets/ElevatedButton.dart';
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
    List<String> texts = [
      "${weatherModel?.current?.humidity ?? ""}%",
      "${weatherModel?.current?.uv ?? ""}",
      "${weatherModel?.current?.windDir ?? ""}",
      "${weatherModel?.current?.pressureMb ?? ""} mb",

    ];

    List<String> title = [
      "Humidity",
      'UV Index',
      'Wind Direction',
      'Pressure'
    ];
    List<IconData> icons = [Icons.water_drop_rounded, Icons.sunny, Icons.wind_power_outlined, Icons.compare_arrows];

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
            backgroundColor: Color(0xBBA3D8FF),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 50,left: 10,right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HelpScreenPage()));
                          },
                        ),

                        Expanded(
                          child: TextField(
                            cursorColor: Colors.white70,
                            style:  TextStyle(color: Colors.white70),
                            controller: controller,
                            decoration: InputDecoration(
                              suffixIcon:  CustomButtons(
                                onPressed: () async {
                                  WeatherModel fetchedWeather = await Repo().getWeather(controller.text);
                                  setState(() {
                                    weatherModel = fetchedWeather; // Assigning fetched weather to weatherModel
                                  });
                                }, icon: Icons.search, size: 22,
                              ),

                              labelText: "Search  Location",
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

                        IconButton(
                          icon: Icon(Icons.clear, size: 15, color: Colors.white70,),
                          onPressed: () {
                            controller.clear();
                          },
                        ),

                      ],
                    ),
                    SizedBox(height: 20),
                    CustomFontText(
                      text: "${weatherModel?.location?.name ?? ""}, ${weatherModel?.location?.country ?? ""}",
                      fontSize: 30,
                    ),
                    Container(
                      width: 500,
                      height: 260,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 40,
                            right: 30,
                            child: Container(
                              width: 100,
                              height: 50,
                              child: Stack(
                                children: [
                                  if (weatherModel?.current?.condition?.icon != null)
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Image.network(
                                        'https:${weatherModel?.current?.condition?.icon}',
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 30,
                            left: 20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  " ${(weatherModel?.current?.tempC ?? 0).toInt()}°",
                                  style: GoogleFonts.pacifico(
                                    fontSize: 90,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                CustomFontText(
                                  text: "${weatherModel?.current?.condition?.text ?? ""}",
                                  fontSize: 16,
                                ),
                                SizedBox(height: 50),
                                CustomFontText(
                                  text: "Feels like ${(weatherModel?.current?.feelslikeC ??0).toInt()} °",
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Container(
                        width: 500,
                        height: 300,
                        child: CustomGridView(
                          texts: texts,
                          icons: icons, title: title,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomElevButton(
                            text: 'Save', onpressed: () {  },
                          ),
                        ),
                        CustomElevButton(
                          text: 'Update', onpressed: () {  },
                        )
                      ],
                    )

                    // Image
                    // if (weatherModel?.current?.condition?.icon != null)
                    //   Image.network(
                    //     'https:${weatherModel?.current?.condition?.icon}',
                    //   ),
                    // Text("Lat: ${weatherModel?.location?.lat ?? "Null"}", style: TextStyle(color: Colors.white),) ,
                    // Text("Location: ${weatherModel?.location?.country ?? "Null"}",style: TextStyle(color: Colors.white),),
                    // Text("Local Time: ${weatherModel?.location?.localtime ?? "Null"}",style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}