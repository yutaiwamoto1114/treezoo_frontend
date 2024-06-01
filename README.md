<!-- omit in toc -->
# treezoo_frontend

動物園で暮らす動物たちの家系図アプリ「TreeZoo」のフロントエンドを提供するFlutterプロジェクトです。バックエンドを提供するGoプロジェクトは [treezoo_backend](https://github.com/yutaiwamoto1114/treezoo_backend) にて公開しています。

- [1. 構成](#1-構成)
- [2. ディレクトリ構成](#2-ディレクトリ構成)
- [3. デバッグ方法](#3-デバッグ方法)
- [4. ビルド方法](#4-ビルド方法)
  - [4.1. Webビルド(PCブラウザ)](#41-webビルドpcブラウザ)
  - [4.2. iOSビルド](#42-iosビルド)
  - [4.3. Androidビルド](#43-androidビルド)
  - [4.4. Windowsビルド](#44-windowsビルド)
- [5. デプロイ](#5-デプロイ)
  - [5.1. Apache HTTP Serverへのデプロイ](#51-apache-http-serverへのデプロイ)

## 1. 構成
- Flutter 3.22.1
  - Riverpod
  - Http
  - Logger
  - Google Fonts

## 2. ディレクトリ構成
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
│   ├── core: 例外クラスやLoggerなどビジネスロジックに無関係なコアクラスを管理します。
│   ├── infrastructure: API通信を行うためのインターフェースを提供します。
│   ├── model: データ型を定義するモデルクラスをまとめます。
│   ├── provider: Riverpodによって管理される状態管理変数をまとめます。
│   ├── service: ビジネスロジックの役割を持つクラスをまとめます。
│   ├── flavor: 環境切り替えを行う設定ファイルをまとめます。
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

## 3. デバッグ方法
1. VSCodeにFlutterの拡張機能をインストールします。
2. F5キーを押します。

## 4. ビルド方法
デプロイしたいプラットフォームごとにビルドを実施します。
### 4.1. Webビルド(PCブラウザ)
- dev環境
    ```
    flutter build web --dart-define-from-file=lib/flavor/dev.json --base-href=/treezoo/
    ```
- stg環境
    ```
    flutter build web --dart-define-from-file=lib/flavor/stg.json --base-href=/treezoo/
    ```
- pord環境
    ```
    flutter build web --dart-define-from-file=lib/flavor/prod.json --base-href=/treezoo/
    ```

### 4.2. iOSビルド
- 対応予定

### 4.3. Androidビルド
- 対応予定

### 4.4. Windowsビルド
- 対応予定なし

## 5. デプロイ
### 5.1. Apache HTTP Serverへのデプロイ
1. Apache HTTP Server 2.4 をダウンロードし、任意のディレクトリに配置します。
   - [Apache VS17 binaries and modules download](https://www.apachelounge.com/download/`)
2. システム環境変数PathにApache24のbinフォルダへのパスを登録します。
   - `C:\opt\Apache24\bin`
3. httpd.confに以下のディレクティブを追記します。
    ```
    # treezoo deployment
    # Alias設定を追加
    Alias /treezoo "${SRVROOT}/htdocs/treezoo"

    <Directory "${SRVROOT}/htdocs/treezoo">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ```
4. Webビルドしたリソース `\treezoo_frontend\build\web` をApacheのドキュメントルート配下に配置します。
    - `C:\opt\Apache24\htdocs\treezoo`
5. サービス `Apache2.4` を開始します。
6. `http://localhost/treezoo` でアプリケーションの動作確認をします。