import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/viewmodel/weatherbyloc.dart';
import 'package:weather/viewmodel/weatherprovider.dart';
import 'view/introPage.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => WeatherProvider()),
    ChangeNotifierProvider(create: (_) => Weatherbyloc()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Intropage(),
    );
  }
}

