import 'dart:convert';
import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forcust/screens/forcst_dtails.dart';

class DetailsWeather extends StatefulWidget {
  const DetailsWeather({Key? key}) : super(key: key);

  @override
  State<DetailsWeather> createState() => _DetailsWeatherState();
}

class _DetailsWeatherState extends State<DetailsWeather> {
  Position? positon;

  var lat;
  var lon;

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    positon = await Geolocator.getCurrentPosition();
    lat = positon!.latitude;
    lon = positon!.longitude;
    print("latitude : ${lat},longitude: ${lon}");
    fetchWeatherData();
  }

  Map<String, dynamic>? mapOfWeather;
  Map<String, dynamic>? mapOfForecast;

  fetchWeatherData() async {
    String weatherApi =
        "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=906c0c77ba8058de5f2455853703dc3e";
    String forecastApi =
        "https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=906c0c77ba8058de5f2455853703dc3e";
    var weatherResponse = await http.get(Uri.parse(weatherApi));
    var forecastResponse = await http.get(Uri.parse(forecastApi));
    print(weatherResponse.body);
    setState(() {
      mapOfWeather =
          Map<String, dynamic>.from(jsonDecode(weatherResponse.body));
      mapOfForecast =
          Map<String, dynamic>.from(jsonDecode(forecastResponse.body));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: mapOfWeather == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Scaffold(
                backgroundColor: Colors.white.withOpacity(0.3),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForcustDetails(),
                        ),
                      );
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(Jiffy(DateTime.now()).yMMMMEEEEdjm,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200)),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "${mapOfWeather!["main"]["temp"]} °C",
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "${mapOfWeather!["weather"][0]["description"]}",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Image.asset("assets/icons/wind.png"),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Wind",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 2,
                                color: Colors.white,
                              ),
                              Text(
                                  "${mapOfForecast!["list"][0]["wind"]["speed"]} km/h",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Image.asset("assets/icons/hum.png"),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Hum",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 47,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 33,
                                  ),
                                  Text(
                                    "${mapOfWeather!["main"]["humidity"]} %",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
