import 'package:flutter/material.dart';
import '../models/weather_models.dart';

class WeatherAlertCard extends StatelessWidget {
  final List<WeatherAlert> alerts;

  const WeatherAlertCard({super.key, required this.alerts});

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) return const SizedBox.shrink();

    final alertColor = _getAlertColor(alerts.first.level);
    final textColor = _getAlertTextColor(alerts.first.level);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: alertColor,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: EdgeInsets.zero,
          leading: Icon(
            Icons.warning_amber_rounded,
            color: textColor,
          ),
          title: Text(
            alerts.first.title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            '${alerts.length}条预警',
            style: TextStyle(
              color: textColor.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
          collapsedIconColor: textColor,
          iconColor: textColor,
          children: alerts.map((alert) => _AlertItem(alert: alert, parentColor: alertColor)).toList(),
        ),
      ),
    );
  }

  Color _getAlertColor(String level) {
    switch (level) {
      case '红色':
        return const Color(0xFFFFEBEE);
      case '橙色':
        return const Color(0xFFFFF3E0);
      case '黄色':
        return const Color(0xFFFFFDE7);
      case '蓝色':
        return const Color(0xFFE3F2FD);
      default:
        return const Color(0xFFF5F5F5);
    }
  }

  Color _getAlertTextColor(String level) {
    switch (level) {
      case '红色':
        return const Color(0xFFC62828);
      case '橙色':
        return const Color(0xFFE65100);
      case '黄色':
        return const Color(0xFFF57F17);
      case '蓝色':
        return const Color(0xFF1565C0);
      default:
        return const Color(0xFF424242);
    }
  }
}

class _AlertItem extends StatelessWidget {
  final WeatherAlert alert;
  final Color parentColor;

  const _AlertItem({required this.alert, required this.parentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: parentColor,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getLevelColor(),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  alert.level,
                  style: TextStyle(
                    color: _getLevelTextColor(),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  alert.typeName,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: _getAlertTextColor(),
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            alert.text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getAlertTextColor().withValues(alpha: 0.9),
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '发布时间: ${alert.pubTime}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getAlertTextColor().withValues(alpha: 0.7),
                  fontSize: 11,
                ),
          ),
        ],
      ),
    );
  }

  Color _getLevelColor() {
    switch (alert.level) {
      case '红色':
        return const Color(0xFFC62828);
      case '橙色':
        return const Color(0xFFFF9800);
      case '黄色':
        return const Color(0xFFFDD835);
      case '蓝色':
        return const Color(0xFF2196F3);
      default:
        return const Color(0xFF757575);
    }
  }

  Color _getAlertTextColor() {
    switch (alert.level) {
      case '红色':
        return const Color(0xFFC62828);
      case '橙色':
        return const Color(0xFFE65100);
      case '黄色':
        return const Color(0xFFF57F17);
      case '蓝色':
        return const Color(0xFF1565C0);
      default:
        return const Color(0xFF424242);
    }
  }

  Color _getLevelTextColor() {
    switch (alert.level) {
      case '红色':
      case '橙色':
      case '蓝色':
        return Colors.white;
      case '黄色':
        return Colors.black;
      default:
        return Colors.white;
    }
  }
}
