import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/weather_model.dart';
import 'models/forecast_model.dart';

class WeatherService {
  static const String _geocodingUrl = 'https://geocoding-api.open-meteo.com/v1/search';
  static const String _weatherUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<Map<String, dynamic>> _getCityCoordinates(String cityName) async {
    final url = Uri.parse('$_geocodingUrl?name=$cityName&count=1&language=en&format=json');
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      if (data['results'] != null && data['results'].isNotEmpty) {
        final city = data['results'][0];
        return {
          'latitude': city['latitude'],
          'longitude': city['longitude'],
          'name': city['name'],
          'country': city['country'] ?? '',
        };
      } else {
        throw Exception('City not found');
      }
    } else {
      throw Exception('Failed to get coordinates');
    }
  }

  Future<Map<String, dynamic>> getWeatherByCity(String cityName) async {
    final cityData = await _getCityCoordinates(cityName);
    
    final lat = cityData['latitude'];
    final lon = cityData['longitude'];
    
    final url = Uri.parse(
      '$_weatherUrl?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto&forecast_days=7'
    );
    
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      final currentWeather = WeatherModel(
        cityName: cityData['name'],
        country: cityData['country'],
        temperature: data['current']['temperature_2m'].toDouble(),
        description: _getWeatherDescription(data['current']['weather_code']),
        icon: _getWeatherIcon(data['current']['weather_code']),
        humidity: data['current']['relative_humidity_2m'],
        windSpeed: data['current']['wind_speed_10m'].toDouble(),
        dateTime: DateTime.parse(data['current']['time']),
      );
      
      final List<ForecastModel> forecast = [];
      final dailyData = data['daily'];
      final List<String> dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      
      for (int i = 1; i < dailyData['time'].length; i++) {
        final date = DateTime.parse(dailyData['time'][i]);
        final temp = dailyData['temperature_2m_max'][i].toDouble();
        final weatherCode = dailyData['weather_code'][i];
        
        final dayName = dayNames[date.weekday - 1];
        
        forecast.add(ForecastModel(
          dayName: dayName,
          temperature: temp,
          icon: _getWeatherIcon(weatherCode),
          description: _getWeatherDescription(weatherCode),
          humidity: null,
        ));
      }
      
      return {
        'current': currentWeather,
        'forecast': forecast,
      };
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  String _getWeatherDescription(int code) {
    if (code == 0) return 'Clear sky';
    if (code <= 3) return 'Partly cloudy';
    if (code <= 49) return 'Foggy';
    if (code <= 59) return 'Drizzle';
    if (code <= 69) return 'Rain';
    if (code <= 79) return 'Snow';
    if (code <= 84) return 'Rain showers';
    if (code <= 99) return 'Thunderstorm';
    return 'Unknown';
  }

  String _getWeatherIcon(int code) {
    if (code == 0) return '01d';
    if (code <= 3) return '02d';
    if (code <= 49) return '50d';
    if (code <= 59) return '09d';
    if (code <= 69) return '10d';
    if (code <= 79) return '13d';
    if (code <= 84) return '09d';
    if (code <= 99) return '11d';
    return '01d';
  }
}
