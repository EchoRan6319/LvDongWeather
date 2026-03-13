# 轻氧天气 (Pure Weather)

一款使用 Flutter 和 Material You Design 构建的现代化跨平台天气应用。

![应用图标](assets/icons/app_icon.svg)

## 特性

- 🌤️ **多数据源天气** - 和风天气、彩云天气 API
- 🎨 **Material You 设计** - 动态主题色、深色/浅色主题
- 📍 **城市管理** - 多城市支持、拖拽排序、定位服务
- 📊 **天气详情** - 实时温度、小时/七日预报、空气质量、天气预警
- 🔔 **通知提醒** - 极端天气预警推送
- 🤖 **天气助手** - 基于 DeepSeek API 的智能问答
- 🌍 **国际化** - 支持中文和英文切换

## 平台支持

- Android
- Windows
- iOS / macOS / Linux / Web（可构建）

## 技术栈

| 分类 | 技术 |
|------|------|
| 框架 | Flutter 3.41.3+ |
| 状态管理 | Riverpod 2.6+ |
| 网络请求 | Dio |
| 数据模型 | Freezed + JSON Serializable |
| 本地存储 | SharedPreferences |
| 定位服务 | Geolocator |
| 动画 | Flutter Animate |
| 动态主题 | Dynamic Color |

## 项目结构

```
lib/
├── core/              # 核心配置（主题、常量）
├── models/            # 数据模型
├── providers/         # 状态管理
├── screens/           # 页面
├── services/          # API 服务
├── widgets/           # 通用组件
└── main.dart          # 应用入口
```

## 快速开始

### 环境准备

1. 安装 Flutter SDK
2. 克隆项目
   ```bash
   git clone https://github.com/EchoRan6319/PureWeather.git
   cd PureWeather
   ```

### API 配置

1. 申请 API Key：
   - [和风天气](https://dev.qweather.com/)
   - [彩云天气](https://open.caiyunapp.com/)
   - [高德地图](https://lbs.amap.com/)
   - [DeepSeek](https://platform.deepseek.com/)（可选）

2. 在项目根目录创建 `.env` 文件：
   ```env
   QWEATHER_API_KEY=your_key
   CAIYUN_API_KEY=your_key
   AMAP_API_KEY=your_key
   AMAP_WEB_KEY=your_key
   DEEPSEEK_API_KEY=your_key
   ```

### 运行

```bash
flutter pub get
flutter run
```

### 构建

```bash
# Android
flutter build apk --release

# Windows
flutter build windows --release

# 其他平台
flutter build [ios|macos|linux|web]
```

## 版本历史

详见 [CHANGELOG.md](CHANGELOG.md)

## 许可证

MIT License
