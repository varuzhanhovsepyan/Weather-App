import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'features/weather/weather_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherState(),
      child: const WeatherApp(),
    ),
  );
}
