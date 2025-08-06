import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/data.dart';

class WeatherProvider extends ChangeNotifier {
  List<Data> weatherData = [];
  List<String> cities = [];
  bool isLoading = false;
  Timer? debounce;
  Future<void> addWeather(String city) async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=930b59dd03c67c8772619fc45f4b8530&units=metric'),
    );
    isLoading = false;
    notifyListeners();
    if (response.statusCode == 200) {
      final data = Data.fromJson(json.decode(response.body));
      weatherData.add(data);
      notifyListeners(); // To update UI
    } else {
      throw Exception('Failed to load weather data');
    }
  }
  Future<void> removeWeather(int index) async {
    if (index >= 0 && index < weatherData.length) {
      weatherData.removeAt(index);
      notifyListeners(); // To update UI
    }
  }
  Future<void> clearWeather() async {
    weatherData.clear();
    notifyListeners(); // To update UI
  }

  Future<void> saveCacheWeather() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cacheWeather', jsonEncode(weatherData.map((data) => data.toJson()).toList()));
  }

  Future<void> loadCacheWeather()async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString('cacheWeather');
    if (cachedData != null) {
      final List<dynamic> jsonList = jsonDecode(cachedData);
      weatherData = jsonList.map((json) => Data.fromJson(json)).toList();
      notifyListeners(); // To update UI
    }
  }
  Future<void> fetchCity(String city)async{
    final response = await http.get(Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=5&appid=930b59dd03c67c8772619fc45f4b8530'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      cities.clear(); // Clear previous results
      for (var item in data) {
        cities.add(item['name']);
      }
      notifyListeners(); // To update UI
    } else {
      throw Exception('Failed to load city');
    }
  }

  void searchCityDebounced(String city) {
    if (debounce?.isActive ?? false) debounce!.cancel();

    debounce = Timer(const Duration(milliseconds: 300), () {
      if (city.length >= 3) {
        fetchCity(city);
      }
    });
  }

}
