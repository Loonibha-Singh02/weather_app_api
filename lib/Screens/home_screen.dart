import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_api/Models/weather_model.dart';
import 'package:weather_app_api/Screens/splash_screen.dart';
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
  final TextEditingController controller = TextEditingController();
  late SharedPreferences prefs;
  WeatherModel? weatherModel;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      setState(() {
        this.prefs = prefs;
        final savedLocation = prefs.getString('location');
        if (savedLocation != null && savedLocation.isNotEmpty) {
          controller.text = savedLocation;
          fetchWeather(savedLocation);
        } else {
          getCurrentLocation();
        }
      });
    });
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    fetchWeatherByLocation(position.latitude, position.longitude);
  }

  Future<void> fetchWeatherByLocation(double latitude, double longitude) async {
    WeatherModel fetchedWeather = await Repo().getWeatherByLL(latitude, longitude);
    setState(() {
      weatherModel = fetchedWeather;
    });
  }

  Future<void> fetchWeather(String city) async {
    WeatherModel fetchedWeather = await Repo().getWeather(city);
    setState(() {
      weatherModel = fetchedWeather;
    });
  }

  Future<void> _saveLocation(String location) async {
    await prefs.setString('location', location);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(child: Text("Location saved successfully")),
        duration: Duration(
          seconds: 1
        ),
      ),
    );
  }

  Future<void> _showErrorDialog() async{
    await showDialog(
        context: context,
        builder: (context)=> AlertDialog(
              title: const Text("Error"),
          content: const Text("Empty search field"),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("Ok")
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> texts = [
      "${weatherModel?.current?.humidity ?? ""}%",
      "${weatherModel?.current?.uv ?? ""}",
      (weatherModel?.current?.windDir ?? ""),
      "${weatherModel?.current?.pressureMb ?? ""} mb",
    ];

    List<String> title = [
      "Humidity",
      'UV Index',
      'Wind Direction',
      'Pressure'
    ];
    List<IconData> icons = [
      Icons.water_drop_rounded,
      Icons.sunny,
      Icons.wind_power_outlined,
      Icons.compare_arrows
    ];

    return FocusScope(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color(0xBBA3D8FF),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 10, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HelpScreenPage()));
                        },
                      ),
                      Expanded(
                        child: TextField(
                          cursorColor: Colors.white70,
                          style: const TextStyle(color: Colors.white70),
                          controller: controller,
                          decoration: InputDecoration(
                            suffixIcon: CustomButtons(
                              onPressed: () async {
                                if (controller.text.isEmpty) {
                                  getCurrentLocation();
                                } else {
                                  fetchWeather(controller.text);
                                }
                              },
                              icon: Icons.search,
                              size: 22,
                            ),
                            labelText: "Search Location",
                            labelStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear, size: 15, color: Colors.white70,),
                        onPressed: () {
                          controller.clear();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomFontText(
                    text: "${weatherModel?.location?.name ?? ""}, ${weatherModel?.location?.country ?? ""}",
                    fontSize: 30,
                  ),
                  SizedBox(
                    width: 500,
                    height: 260,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 40,
                          right: 30,
                          child: SizedBox(
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
                                style: const TextStyle(
                                  fontSize: 90,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              CustomFontText(
                                text: weatherModel?.current?.condition?.text ?? "",
                                fontSize: 16,
                              ),
                              const SizedBox(height: 50),
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
                    child: SizedBox(
                      width: 500,
                      height: 300,
                      child: CustomGridView(
                        texts: texts,
                        icons: icons, title: title,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomElevButton(
                          text: "Save",
                          onpressed: () {
                            if (controller.text.isNotEmpty) {
                              _saveLocation(controller.text);
                            }
                            else{
                              _showErrorDialog();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
