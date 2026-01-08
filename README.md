# 刮刮樂策略分析工具

一個視覺化的刮刮樂熱區分析工具，幫助使用者了解不同玩家策略下的刮選分佈情況。

## 功能特色

### 策略選擇
提供四種不同的玩家策略分析：
- **常態分佈** - 標準的機率分佈模式
- **新手較多** - 適合新玩家的熱區分析
- **老手較多** - 資深玩家偏好的區域
- **混合模式** - 新手與老手各半的綜合分析

### 格數選擇
支援三種不同的彩券尺寸：
- 8 × 5
- 10 × 12
- 16 × 10

### 響應式設計 (RWD)
自動適應不同裝置尺寸：
- **桌面模式** (≥1100px) - 左右雙欄佈局
- **平板模式** (≥700px) - 精簡雙欄佈局
- **手機模式** (<700px) - 單欄垂直佈局

### 明暗主題切換
支援淺色與深色兩種主題模式，可隨時切換

### 圖片檢視功能
- 縮放控制按鈕 (放大/縮小/重置)
- 雙指手勢縮放支援
- 全螢幕檢視模式
- 顯示目前縮放比例

## 技術架構

- Flutter 3.x
- Dart SDK ^3.6.1
- 支援多平台：Web、Android、iOS、Windows、macOS、Linux

## 專案結構

```
lib/
├── main.dart              # 應用程式入口
├── models/                # 資料模型
│   ├── models.dart
│   ├── strategy_info.dart # 策略資訊定義
│   └── grid_size_info.dart# 格數資訊定義
├── theme/                 # 主題系統
│   ├── theme.dart
│   └── app_theme.dart     # 明暗主題配置
├── screens/               # 畫面
│   ├── screens.dart
│   └── home_screen.dart   # 主畫面與 RWD 邏輯
└── widgets/               # 可重用元件
    ├── widgets.dart
    ├── header_widget.dart # 標題與主題切換
    ├── strategy_card.dart # 策略選擇卡片
    ├── size_selector.dart # 尺寸選擇器
    ├── section_title.dart # 區段標題
    ├── result_panel.dart  # 結果顯示面板
    └── image_viewer.dart  # 圖片檢視器（含縮放/全螢幕）
```

## 快速開始

### 環境需求

- Flutter SDK 3.6.1 或更新版本
- Dart SDK ^3.6.1

### 安裝與執行

```bash
# 取得依賴套件
flutter pub get

# 執行開發版本
flutter run

# 執行 Web 版本
flutter run -d chrome

# 編譯 Web 版本
flutter build web

# 編譯 Android APK
flutter build apk

# 編譯 iOS
flutter build ios
```

### Web 部署

編譯完成後，`build/web` 資料夾內的檔案可直接部署至任何靜態網頁伺服器。

## 授權

此專案僅供學術研究與個人學習使用。
