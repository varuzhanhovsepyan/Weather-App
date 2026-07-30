import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../features/theme/theme_state.dart';
import '../l10n/app_localizations.dart';
import '../pages/weather_home/weather_home_screen.dart';
import '../shared/theme/theme.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder: (context, themeState, child) {
        return MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeState.themeMode,

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: const [
            Locale('en'),
            Locale('ru'),
          ],

          home: const WeatherHomeScreen(),
        );
      },
    );
  }
}