import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get qweatherApiKey => dotenv.env['QWEATHER_API_KEY'] ?? '';
  static String get qweatherBaseUrl => dotenv.env['QWEATHER_BASE_URL'] ?? 'https://devapi.qweather.com/v7';
  
  static String get caiyunApiKey => dotenv.env['CAIYUN_API_KEY'] ?? '';
  static String get caiyunBaseUrl => dotenv.env['CAIYUN_BASE_URL'] ?? 'https://api.caiyunapp.com/v2.6';
  
  static String get amapApiKey => dotenv.env['AMAP_API_KEY'] ?? '';
  static String get amapWebKey => dotenv.env['AMAP_WEB_KEY'] ?? '';
  
  static String get deepseekApiKey => dotenv.env['DEEPSEEK_API_KEY'] ?? '';
  static String get deepseekBaseUrl => dotenv.env['DEEPSEEK_BASE_URL'] ?? 'https://api.deepseek.com/v1';
  
  static bool get isConfigured {
    return qweatherApiKey.isNotEmpty && 
           amapApiKey.isNotEmpty;
  }
}
