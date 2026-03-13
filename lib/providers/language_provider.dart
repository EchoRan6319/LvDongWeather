import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 语言模式枚举
enum LanguageMode { system, zh, en }

/// 语言设置通知器
class LanguageNotifier extends StateNotifier<LanguageMode> {
  static const String _key = 'language_mode';

  LanguageNotifier() : super(LanguageMode.system) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_key) ?? 0;
    state = LanguageMode.values[index];
  }

  Future<void> setLanguage(LanguageMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, mode.index);
    state = mode;
  }

  Locale? get locale {
    switch (state) {
      case LanguageMode.zh:
        return const Locale('zh', 'CN');
      case LanguageMode.en:
        return const Locale('en', 'US');
      case LanguageMode.system:
        return null; // Follow system
    }
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, LanguageMode>((ref) {
  return LanguageNotifier();
});
