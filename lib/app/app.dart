import 'package:flutter/material.dart';
import '../pages/weather_home/weather_home_screen.dart';
import '../shared/theme/theme.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const WeatherHomeScreen(),
    );
  }
}
