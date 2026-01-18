import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/weather/weather_state.dart';
import '../../shared/ui/molecules/forecast_day_item.dart';
import '../../shared/theme/colors.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherState>().setMockWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherState>(
        builder: (context, weatherState, child) {
          final weather = weatherState.currentWeather;
          
          if (weather == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Container(
            color: const Color(0xFFFAFAFA),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/location.png',
            width: 32,
            height: 32,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchCityScreen(),
                ),
              );
            },
            child: Image.asset(
              'assets/images/search.png',
              width: 32,
              height: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainWeatherSection(BuildContext context, dynamic weather) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/sunBackground.png',
          width: screenWidth * 0.5,
          height: screenWidth * 0.5,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/mark.png',
                        width: 16,
                        height: 16,
                        color: const Color(AppColors.textSecondary),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        weather.cityName,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${weather.temperature.toInt()}°',
                    style: const TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      color: Color(AppColors.textPrimary),
                      letterSpacing: -4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    weather.description,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.textPrimary),
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
        color: Colors.white,
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
