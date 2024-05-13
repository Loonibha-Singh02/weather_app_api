import 'package:flutter/material.dart';
import 'package:weather_app_api/Models/weather_model.dart';
import 'package:weather_app_api/Screens/help_screen.dart';
import 'package:weather_app_api/repo.dart';


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
            appBar: AppBar(
              title: const Text("Weather Info"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
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
                          controller: controller,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                controller.clear();
                              },
                            ),
                            labelText: "Search",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          WeatherModel fetchedWeather = await Repo().getWeather(controller.text);
                          setState(() {
                            weatherModel = fetchedWeather; // Assigning fetched weather to weatherModel
                          });
                        },
                        child: Text('Search'),
                      ),
                    ],
                  ),
                  Text("Lat: ${weatherModel?.location?.lat ?? "Null"}") ,
                  Text("Location: ${weatherModel?.location?.country ?? "Null"}"),
                  Text("Local Time: ${weatherModel?.location?.localtime ?? "Null"}")
                ],
              ),
            )
        ),
      ),
    );
  }
}
