import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'features/weather/weather_state.dart';
import 'features/theme/theme_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherState(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeState(),
        ),
      ],
      child: const WeatherApp(),
    ),
  );
}
