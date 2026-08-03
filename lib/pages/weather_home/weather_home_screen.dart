import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/notifications/notification_state.dart';
import '../../features/weather/weather_state.dart';
import '../../shared/ui/molecules/forecast_day_item.dart';
import '../../shared/constants/app_assets.dart';
import '../../features/theme/theme_state.dart';
import '../examples/examples_hub_screen.dart';
import '../notifications/fcm_token_dialog.dart';
import '../search_city/search_city_screen.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<WeatherState>().setMockWeather();

      final notificationState = context.read<NotificationState>();
      await notificationState.initialize();

      if (!mounted) return;
      await showFcmTokenDialog(context, notificationState);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherState>(
        builder: (context, weatherState, child) {
          final weather = weatherState.currentWeather;

          if (weather == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SafeArea(
              child: Column(
                children: [
                  _buildAppBar(context),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 49),
                          _buildMainWeatherSection(context, weather),
                          const SizedBox(height: 78),
                          _buildForecastList(weatherState),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final themeState = context.watch<ThemeState>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppAssets.location,
            width: 32,
            height: 32,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExamplesHubScreen(),
                    ),
                  );
                },
                child: Icon(
                  Icons.science_outlined,
                  size: 32,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 16),

IconButton(
  onPressed: () {
    context.read<ThemeState>().toggleTheme();
  },
  icon: Icon(
    themeState.isDarkMode
        ? Icons.dark_mode
        : Icons.light_mode,
  ),
  color: theme.colorScheme.onSurface,
),

const SizedBox(width: 8),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchCityScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  AppAssets.search,
                  width: 32,
                  height: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainWeatherSection(
    BuildContext context,
    dynamic weather,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.sunBackground,
          width: screenWidth * 0.5,
          height: screenWidth * 0.5,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppAssets.mark,
                      width: 16,
                      height: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      weather.cityName,
                      style: TextStyle(
                        fontSize: 15,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '${weather.temperature.toInt()}°',
                  style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.w400,
                    height: 1,
                    color: theme.colorScheme.onSurface,
                    letterSpacing: -4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  weather.description,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForecastList(WeatherState weatherState) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: List.generate(
          weatherState.forecast.length,
          (index) {
            final forecast = weatherState.forecast[index];

            return ForecastDayItem(
              dayName: forecast.dayName,
              icon: forecast.icon,
              temperature: forecast.temperature,
              humidity: forecast.humidity,
              isLast: index == weatherState.forecast.length - 1,
            );
          },
        ),
      ),
    );
  }
}