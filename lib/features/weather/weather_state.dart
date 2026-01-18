import 'package:flutter/material.dart';
import 'models/weather_model.dart';
import 'models/forecast_model.dart';
import 'weather_service.dart';

class WeatherState extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  
  WeatherModel? _currentWeather;
  List<ForecastModel> _forecast = [];
  List<String> _searchHistory = [];
  bool _isLoading = false;
  String? _error;

  WeatherModel? get currentWeather => _currentWeather;
  List<ForecastModel> get forecast => _forecast;
  List<String> get searchHistory => _searchHistory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> setMockWeather() async {
    await searchCity('Cupertino');
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
