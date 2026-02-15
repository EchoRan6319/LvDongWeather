import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/weather_models.dart';

class WeatherIndicesCard extends StatelessWidget {
  final List<WeatherIndices> indices;

  const WeatherIndicesCard({super.key, required this.indices});

  @override
  Widget build(BuildContext context) {
    if (indices.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.tips_and_updates,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '生活指数',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: indices.take(6).map((index) {
                return _IndexItem(index: index)
                    .animate()
                    .fadeIn(delay: Duration(milliseconds: 50 * indices.indexOf(index)));
              }).toList(),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }
}

class _IndexItem extends StatelessWidget {
  final WeatherIndices index;

  const _IndexItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 64) / 3,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            _getIndexIcon(index.type),
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8),
          Text(
            index.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            index.category,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  IconData _getIndexIcon(String type) {
    switch (type) {
      case '1':
        return Icons.directions_run;
      case '2':
        return Icons.directions_car;
      case '3':
        return Icons.checkroom;
      case '5':
        return Icons.opacity;
      case '6':
        return Icons.wb_sunny;
      case '7':
        return Icons.sick;
      case '8':
        return Icons.beach_access;
      case '9':
        return Icons.local_florist;
      default:
        return Icons.info_outline;
    }
  }
}
