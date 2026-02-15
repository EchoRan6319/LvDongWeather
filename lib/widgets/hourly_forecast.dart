import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/weather_models.dart';
import '../core/constants/app_constants.dart';

class HourlyForecast extends StatelessWidget {
  final List<HourlyWeather> hourly;

  const HourlyForecast({super.key, required this.hourly});

  @override
  Widget build(BuildContext context) {
    if (hourly.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '24小时预报',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: hourly.length > 24 ? 24 : hourly.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return _HourlyItem(weather: hourly[index])
                      .animate()
                      .fadeIn(delay: Duration(milliseconds: 50 * index))
                      .slideX(begin: 0.1);
                },
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }
}

class _HourlyItem extends StatelessWidget {
  final HourlyWeather weather;

  const _HourlyItem({required this.weather});

  @override
  Widget build(BuildContext context) {
    final time = DateTime.tryParse(weather.fxTime);
    final hour = time?.hour ?? 0;
    final isNight = hour < 6 || hour > 18;
    final iconCode = int.tryParse(weather.icon) ?? 100;

    return SizedBox(
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time != null ? '${time.hour}:00' : '--:--',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          Icon(
            WeatherCode.getWeatherIcon(iconCode, isNight: isNight),
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8),
          Text(
            '${weather.temp}°',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          if (weather.pop != '0') ...[
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.water_drop,
                  size: 12,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                Text(
                  '${weather.pop}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
