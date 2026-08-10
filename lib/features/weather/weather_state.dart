import 'package:flutter/material.dart';
import 'models/weather_model.dart';
import 'models/forecast_model.dart';
import 'weather_service.dart';

class WeatherState extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  WeatherModel? _currentWeather = WeatherModel(
    cityName: 'Cupertino',
    country: 'United States',
    temperature: 24,
    description: 'Clear sky',
    icon: '01d',
    humidity: 45,
    windSpeed: 3.5,
    dateTime: DateTime.now(),
  );
  List<ForecastModel> _forecast = [
    ForecastModel(
      dayName: 'Tuesday',
      temperature: 25,
      icon: '01d',
      description: 'Clear sky',
    ),
    ForecastModel(
      dayName: 'Wednesday',
      temperature: 23,
      icon: '02d',
      description: 'Partly cloudy',
    ),
    ForecastModel(
      dayName: 'Thursday',
      temperature: 22,
      icon: '10d',
      description: 'Rain',
    ),
  ];
  List<String> _searchHistory = [];
  bool _isLoading = false;
  String? _error;

  WeatherModel? get currentWeather => _currentWeather;
  List<ForecastModel> get forecast => _forecast;
  List<String> get searchHistory => _searchHistory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setMockWeather() {
    _currentWeather = WeatherModel(
      cityName: 'Cupertino',
      country: 'United States',
      temperature: 24,
      description: 'Clear sky',
      icon: '01d',
      humidity: 45,
      windSpeed: 3.5,
      dateTime: DateTime.now(),
    );
    _forecast = [
      ForecastModel(
        dayName: 'Tuesday',
        temperature: 25,
        icon: '01d',
        description: 'Clear sky',
      ),
      ForecastModel(
        dayName: 'Wednesday',
        temperature: 23,
        icon: '02d',
        description: 'Partly cloudy',
      ),
      ForecastModel(
        dayName: 'Thursday',
        temperature: 22,
        icon: '10d',
        description: 'Rain',
      ),
    ];
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  void addToSearchHistory(String cityName) {
    if (!_searchHistory.contains(cityName)) {
      _searchHistory.insert(0, cityName);
      if (_searchHistory.length > 5) {
        _searchHistory = _searchHistory.sublist(0, 5);
      }
      notifyListeners();
    }
  }

  void removeFromSearchHistory(String cityName) {
    _searchHistory.remove(cityName);
    notifyListeners();
  }

  void clearSearchHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  Future<void> searchCity(String cityName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final weatherData = await _weatherService.getWeatherByCity(cityName);

      _currentWeather = weatherData['current'];
      _forecast = weatherData['forecast'];

      addToSearchHistory(cityName);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
