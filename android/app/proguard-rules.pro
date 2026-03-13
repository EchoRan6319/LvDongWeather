# Flutter ProGuard rules - 优化版本

# Flutter wrapper - 保留核心类
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.common.** { *; }
-keep class io.flutter.embedding.** { *; }

# 保留插件方法调用处理器
-keepclassmembers class * implements io.flutter.plugin.common.MethodChannel$MethodCallHandler {
    public void onMethodCall(io.flutter.plugin.common.MethodCall, io.flutter.plugin.common.MethodChannel$Result);
}

# 保留 Dart VM 类
-keep class com.dartlang.vm.** { *; }

# 保留序列化相关的类和方法（用于 JSON 解析）
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# 保留枚举类
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# 保留 native 方法
-keepclasseswithmembernames class * {
    native <methods>;
}

# 保留 Parcelable 实现类
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# 忽略 Google Play Core 缺失类警告
-dontwarn com.google.android.play.core.**
-dontwarn com.google.android.play.core.tasks.**

# 优化选项
-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontpreverify
-verbose
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*

# 保留行号信息（便于调试）
-keepattributes SourceFile,LineNumberTable

# 保留注解
-keepattributes *Annotation*

# 保留泛型签名
-keepattributes Signature

# 保留异常、内部类、合成类等
-keepattributes Exceptions,InnerClasses,Synthetic

# 删除日志代码
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
    public static *** w(...);
    public static *** e(...);
}
