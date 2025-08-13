# Japan Temperature Mobile

📱 日本全国の気温情報を視覚的に表示する SwiftUI アプリケーション

## 📋 概要

Japan Temperature Mobile は、日本の各地方の気温データを美しい UI で表示し、体感温度の計算や気温の変化をトラッキングする iOS アプリです。教育目的やデモンストレーション用として設計されており、SwiftUI の様々な機能を活用したモダンなアプリ構成となっています。

## ✨ 主な機能

### 🌡️ 気温表示機能

- **地方別気温表示**: 北海道から沖縄まで 9 地方の気温を一覧表示
- **体感温度計算**: 湿度と風速を考慮した体感温度の自動計算
- **単位切り替え**: 摂氏（℃）と華氏（℉）の表示切り替え
- **カラーコード**: 気温帯別の色分け表示（涼しい → 暑い）

### 📊 データ機能

- **リアルタイム更新**: 気温データの手動更新機能
- **ソート機能**: 気温順・地域順での並び替え
- **温度履歴**: 過去の気温変化のトレンド表示
- **統計情報**: 平均気温、最高気温、最低気温の表示

### 📈 グラフ機能

- **過去 30 日間のグラフ**: Charts framework を使用した気温推移グラフ
- **インタラクティブ表示**: タップで詳細情報の表示

### 🎨 UI/UX 機能

- **レスポンシブデザイン**: iPhone、iPad、Mac に対応
- **アクセシビリティ**: VoiceOver サポート、色覚サポート対応
- **ダークモード**: システム設定に応じた自動切り替え
- **多言語対応**: 日本語・英語の部分対応

## 🏗️ アーキテクチャ

### MVVM パターン

```
Views/
├── ContentView.swift          # メインビュー
├── Components/               # 再利用可能コンポーネント
│   ├── RegionRowView.swift
│   ├── StatisticsView.swift
│   └── ...
├── GraphView.swift           # Charts framework使用
└── ...

ViewModels/
├── TemperatureViewModel.swift    # メイン気温データ管理
├── WeatherViewModel.swift        # 天気API連携
├── FavoritesViewModel.swift      # お気に入り機能
└── ...

Models/
├── RegionTemperature.swift      # 地域気温データモデル
├── ApparentTemperature.swift    # 体感温度計算
├── TemperatureUnit.swift        # 単位定義
└── ...

Utils/
├── TemperatureFormatter.swift   # 気温表示フォーマット
├── TempColorScheme.swift        # 色分けロジック
└── ...
```

### 主要コンポーネント

#### 🎯 TemperatureViewModel

- 地域別気温データの管理
- 体感温度の計算
- ソート・フィルター機能
- 履歴データの保持

#### 🌈 体感温度計算 (ApparentTemperature)

```swift
// 26℃以上 & 湿度40%以上 → 暑さ指数風
// 10℃以下 & 風速1.5m/s以上 → 風冷指数風
// その他 → 実測温度そのまま
```

#### 🎨 カラースキーム (TempColorScheme)

- 6 段階の温度帯（極寒〜猛暑）
- アクセシビリティ対応の色調整
- ダークモード対応

## 🛠️ 技術スタック

### 必須要件

- **iOS 18.5+** / **macOS 15.5+** / **visionOS 2.5+**
- **Xcode 16.4+**
- **Swift 5.0+**

### 使用 Framework

- **SwiftUI**: メイン UI Framework
- **Charts**: グラフ表示 (iOS 16.0+)
- **Combine**: リアクティブプログラミング
- **Foundation**: 基本機能

### 外部 API（オプション）

- **OpenWeatherMap API**: 実際の天気データ取得
  - 環境変数 `API_KEY` で設定

## 🚀 セットアップ

### 1. プロジェクトのクローン

```bash
git clone [repository-url]
cd Japan-Temperature_Mobile
```

### 2. Xcode でプロジェクトを開く

```bash
open Japan-Temperature_Mobile.xcodeproj
```

### 3. 環境変数の設定（オプション）

実際の API 連携を行う場合：

```bash
# .envファイルを作成
echo "API_KEY=your_openweathermap_api_key" > .env
```

### 4. ビルド・実行

- Xcode で `Cmd + R` でビルド・実行
- シミュレーター または 実機で動作確認

## 📱 対応プラットフォーム

| プラットフォーム | 最小バージョン | 状態        |
| ---------------- | -------------- | ----------- |
| iPhone           | iOS 18.5+      | ✅ フル対応 |
| iPad             | iPadOS 18.5+   | ✅ フル対応 |
| Mac (Catalyst)   | macOS 15.5+    | ✅ 対応     |
| Apple Vision Pro | visionOS 2.5+  | ✅ 対応     |

## 🔧 主な設定

### ビルド設定

- **Bundle ID**: `com.gmail.d3rvi2lg1ont69d.Japan-Temperature-Mobile`
- **Deployment Target**: iOS 18.5, macOS 15.5, visionOS 2.5
- **Swift Version**: 5.0
- **App Groups**: 有効

### アプリ権限

- **Sandbox**: 有効
- **User Selected Files (Read Only)**: 有効

## 🎨 UI 設計思想

### デザインガイドライン

1. **シンプル & クリーン**: 情報の可読性を最優先
2. **カラフル & 直感的**: 温度帯を色で即座に識別
3. **アクセシブル**: 全ユーザーが利用可能
4. **レスポンシブ**: あらゆる画面サイズに対応

### 色彩設計

- **極寒**: 青系（< 0℃）
- **寒冷**: シアン系（0-10℃）
- **涼しい**: 緑系（10-20℃）
- **暖かい**: オレンジ系（20-30℃）
- **暑い**: 赤系（30-35℃）
- **猛暑**: 濃赤系（35℃+）

## 🧪 サンプルデータ

アプリには以下の 9 地方のサンプルデータが含まれています：

- 北海道、東北、関東、中部、近畿、中国、四国、九州、沖縄

各地方には以下のデータが含まれます：

- 実測温度（-2℃ 〜 27℃ の範囲）
- 湿度（35% 〜 75%）
- 風速（0.7 〜 3.0 m/s）

---

**作成日**: 2025 年 7 月
**最終更新**: 2025 年 8 月
**開発環境**: Xcode 16.4, iOS 18.5
