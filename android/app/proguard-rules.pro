# Flutter Core
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Models (Keep keys for JSON serialization)
-keepclassmembers class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# Keep the models themselves if using reflection/serialization
-keep class com.echoran.pureweather.models.** { *; }

# OkHttp/Retrofit/Dio if needed (though Flutter usually handles this)
-dontwarn okio.**
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
