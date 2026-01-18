import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class ForecastDayItem extends StatelessWidget {
  final String dayName;
  final String icon;
  final double temperature;
  final int? humidity;
  final bool isLast;

  const ForecastDayItem({
    super.key,
    required this.dayName,
    required this.icon,
    required this.temperature,
    this.humidity,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  dayName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(AppColors.textPrimary),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Image.asset(
                'assets/images/sun.png',
                width: 32,
                height: 32,
              ),
              if (humidity != null) ...[
                const SizedBox(width: 8),
                Text(
                  '$humidity%',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(AppColors.textSecondary).withValues(alpha: 0.6),
                  ),
                ),
              ],
              const Spacer(),
              Text(
                '${temperature.toInt()}°',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(AppColors.textPrimary),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            height: 1,
            color: const Color(0xFFF0F0F0),
          ),
      ],
    );
  }
}
