import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/api_config.dart';

class CaiyunWeatherService {
  final Dio _dio;
  final String _apiKey;
  final String _baseUrl;

  CaiyunWeatherService({
    Dio? dio,
    String? apiKey,
    String? baseUrl,
  })  : _dio = dio ?? Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        )),
        _apiKey = apiKey ?? ApiConfig.caiyunApiKey,
        _baseUrl = baseUrl ?? ApiConfig.caiyunBaseUrl;

  Future<CaiyunMinuteRain> getMinuteRain(double lat, double lon) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/$_apiKey/$lon,$lat/forecast',
      );

      final data = response.data;
      if (data['status'] == 'ok') {
        return CaiyunMinuteRain.fromJson(data);
      }
      throw Exception('Caiyun weather data not available');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRealtimeWeather(double lat, double lon) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/$_apiKey/$lon,$lat/realtime',
      );

      final data = response.data;
      if (data['status'] == 'ok') {
        return data['result'];
      }
      throw Exception('Caiyun realtime data not available');
    } catch (e) {
      rethrow;
    }
  }
}

class CaiyunMinuteRain {
  final String status;
  final String description;
  final List<MinuteRainItem> precipitation;
  final double probability;

  CaiyunMinuteRain({
    required this.status,
    required this.description,
    required this.precipitation,
    required this.probability,
  });

  factory CaiyunMinuteRain.fromJson(Map<String, dynamic> json) {
    final result = json['result'] ?? {};
    final minutely = result['minutely'] ?? {};
    final precipitation2h = minutely['precipitation_2h'] ?? [];
    
    return CaiyunMinuteRain(
      status: json['status'] ?? '',
      description: minutely['description'] ?? '',
      precipitation: (precipitation2h as List)
          .asMap()
          .entries
          .map((e) => MinuteRainItem(
                minute: e.key * 5,
                value: (e.value as num).toDouble(),
              ))
          .toList(),
      probability: (minutely['probability'] ?? 0.0).toDouble(),
    );
  }

  bool get willRain => probability > 0.3;
  bool get heavyRainComing => precipitation.any((p) => p.value > 5);
}

class MinuteRainItem {
  final int minute;
  final double value;

  MinuteRainItem({required this.minute, required this.value});
}

final caiyunWeatherServiceProvider = Provider<CaiyunWeatherService>((ref) {
  return CaiyunWeatherService();
});
