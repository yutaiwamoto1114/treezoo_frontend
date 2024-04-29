# treezoo_frontend

動物園で暮らす動物たちの家系図アプリ「TreeZoo」のフロントエンドを提供するFlutterプロジェクトです。

## 利用技術
- Dart
- Flutter
- Riverpod

## ディレクトリ構成
以下の記事を参考にディレクトリ構成を定めています。
[【Flutter】そのディレクトリ構成は恋される | Zenn](https://zenn.dev/web_tips/articles/530d02aaf90400)
```
.
├── android
├── ios
├── assets
│   ├── images
│   └── json
├── coverage
├── lib: ソースコードです。
│   ├── component
│   ├── constant: 定数をまとめます。
│   ├── core
│   ├── infrastructure
│   ├── model: データ型を定義するモデルクラスをまとめます。
│   ├── provider: Riverpodによって管理される状態管理変数をまとめます。
│   ├── repository
│   ├── router
│   ├── ui_core
│   ├── view
│   ├── view_model
│   ├── app.dart
│   ├── importer.dart
│   └── main.dart: アプリケーションのエントリーポイントです。
└── test
    ├── constant
    ├── core
    ├── model
    ├── provider
    ├── repository
    ├── ui_core
    └── view_model
```

## デバッグ方法
1. VSCodeにFlutterの拡張機能をインストールします。
2. F5キーを押します。

## ビルド方法
デプロイしたいプラットフォームごとにビルドを実施します。
### Webビルド(PCブラウザ)
### iOSビルド
### Androidビルド
### Windowsビルド

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
