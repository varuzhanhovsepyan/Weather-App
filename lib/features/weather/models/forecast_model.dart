class ForecastModel {
  final String dayName;
  final double temperature;
  final String icon;
  final String description;
  final int? humidity;

  ForecastModel({
    required this.dayName,
    required this.temperature,
    required this.icon,
    required this.description,
    this.humidity,
  });
}
