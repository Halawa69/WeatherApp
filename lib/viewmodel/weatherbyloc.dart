import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../model/getloc.dart';

class Weatherbyloc extends ChangeNotifier {


  Getloc? weatherData;
  
 Future<void> fetchWeather() async {
  try {
    Position position = await getCurrentPosition();
    final double latitude = position.latitude;
    final double longitude = position.longitude;

    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=930b59dd03c67c8772619fc45f4b8530&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      weatherData = Getloc.fromJson(jsonMap);
      notifyListeners();
    } else {
      throw Exception('Failed to load weather data');
    }
  } catch (e) {
    debugPrint('Error fetching weather: $e');
    rethrow;
  }
}


  Future<Position> getCurrentPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}


}
