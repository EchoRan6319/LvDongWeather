import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/weather_models.dart';
import '../services/qweather_service.dart';
import '../services/caiyun_service.dart';
import 'city_provider.dart';

enum WeatherLoadingState {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState {
  final WeatherLoadingState loadingState;
  final WeatherData? weatherData;
  final AirQuality? airQuality;
  final CaiyunMinuteRain? minuteRain;
  final String? errorMessage;

  const WeatherState({
    this.loadingState = WeatherLoadingState.initial,
    this.weatherData,
    this.airQuality,
    this.minuteRain,
    this.errorMessage,
  });

  WeatherState copyWith({
    WeatherLoadingState? loadingState,
    WeatherData? weatherData,
    AirQuality? airQuality,
    CaiyunMinuteRain? minuteRain,
    String? errorMessage,
    bool clearError = false,
    bool clearWeather = false,
  }) {
    return WeatherState(
      loadingState: loadingState ?? this.loadingState,
      weatherData: clearWeather ? null : (weatherData ?? this.weatherData),
      airQuality: clearWeather ? null : (airQuality ?? this.airQuality),
      minuteRain: clearWeather ? null : (minuteRain ?? this.minuteRain),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  bool get isLoading => loadingState == WeatherLoadingState.loading;
  bool get hasData => weatherData != null;
  bool get hasError => errorMessage != null;
}

class WeatherNotifier extends StateNotifier<WeatherState> {
  final QWeatherService _qweatherService;
  final CaiyunWeatherService _caiyunService;
  final Ref _ref;

  WeatherNotifier(this._ref, this._qweatherService, this._caiyunService)
      : super(const WeatherState());

  Future<void> loadWeather(Location location) async {
    state = state.copyWith(
      loadingState: WeatherLoadingState.loading,
      clearError: true,
    );

    try {
      final results = await Future.wait([
        _qweatherService.getFullWeatherData(location.id, location),
        _qweatherService.getAirQuality(location.id),
        _caiyunService.getMinuteRain(location.lat, location.lon),
      ]);

      state = WeatherState(
        loadingState: WeatherLoadingState.loaded,
        weatherData: results[0] as WeatherData,
        airQuality: results[1] as AirQuality?,
        minuteRain: results[2] as CaiyunMinuteRain?,
      );
    } catch (e) {
      state = state.copyWith(
        loadingState: WeatherLoadingState.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    final location = _ref.read(defaultCityProvider);
    if (location != null) {
      await loadWeather(location);
    }
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

final weatherProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>((ref) {
  return WeatherNotifier(
    ref,
    ref.watch(qweatherServiceProvider),
    ref.watch(caiyunWeatherServiceProvider),
  );
});

final weatherForCityProvider =
    FutureProvider.family<WeatherData?, Location>((ref, location) async {
  final service = ref.watch(qweatherServiceProvider);
  try {
    return await service.getFullWeatherData(location.id, location);
  } catch (_) {
    return null;
  }
});
