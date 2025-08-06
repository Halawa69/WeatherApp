import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/view/bottomBar.dart';
import 'package:weather/viewmodel/weatherbyloc.dart';
import 'package:weather/viewmodel/weatherprovider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Weatherbyloc>(context);
    final prev = Provider.of<WeatherProvider>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [Color(0xFF3E2D8F), Color(0xFF8E78C8)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      prov.fetchWeather().then((_) {
                        prev.saveCacheWeather();
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $error')),
                        );
                      });
                    },
                    child: Text('Weather in your area')),
                Image.asset(
                  'assets/WhatsApp_Image_2025-07-29_at_13.29.23_4a4648e1-removebg-preview.png',
                  width: 350,
                  height: 350,
                ),
                if (prev.isLoading) ...[
                  CircularProgressIndicator(),
                ] else if (prov.weatherData != null) ...[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text('${prov.weatherData!.cityName}',
                            style: TextStyle(fontSize: 20, color: Colors.white)),
                        SizedBox(height: 10),
                        Text('${prov.weatherData!.temperature}°C',
                            style: TextStyle(fontSize: 20, color: Colors.white)),
                        SizedBox(height: 10),
                        Text('${prov.weatherData!.description}',
                            style: TextStyle(fontSize: 20, color: Colors.white)),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
