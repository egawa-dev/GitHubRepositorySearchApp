# git_hub_repository_search_app

GitHubのリポジトリを検索するアプリ

## 使用技術一覧

### フレームワーク

Flutter

### 言語

Dart

### アーキテクチャ

BLoC

## 環境

### Flutter

|項目|バージョン|
|-|-|
|Flutter|3.35.2|
|Dart|3.9.0|

### iOS

|項目|バージョン|
|-|-|
|Xcode|16.4.0|
|CocoaPods|1.16.2|

### Android

|項目|バージョン|
|-|-|
|Android Studio|Android Studio Narwhal Feature Drop 2025.1.2 Patch 2|
|CompileSDK|36|
|TargetSDK|36|
|MinSDK|24|
|Gradle Wrapper|8.12|
|Android Gradle Plugin|8.9.1|
|Kotlin|2.1.0|
|JDK|17.0.16|

## ディレクトリ構成


```
.  
├── android   
├── ios  
├── lib  
│   ├── main.dart  
│   ├── <機能名>  
│   │   └── view        // UI  
│   │   ├── bloc        // 状態管理/ビジネスロジック  
│   └── shared          // 全体で共有する機能  
│       ├── data        // データのやりとりを行うレイヤー  
│       ├── model       // データの型・構造  
│       └── repository  // データのやりとりの窓口のレイヤー  
├── pubspec.lock  
├── pubspec.yaml  
├── README.md  
└── test                // テストコード  
```

## 開発環境構築

### Flutterインストール

[Flutter公式のページ](https://docs.flutter.dev/get-started/install)を閲覧してFlutterをインストールしてください。

### パッケージインストール

pubspec.yamlと同ディレクトリにて以下のコマンドを実行して、パッケージをインストールしてください。

```shell
flutter pub get
```

### 動作確認

以下のコマンドを実行して、問題なくデバイス上で実行されることを確認してください。

```she
flutter run
```

## Git運用

[Git Flow](https://zenn.dev/yukun369/articles/3b286fcb308e33)を使用します。
(ただし、今回はリリース作業がないため、releaseブランチとhotfixブランチは使用しません。)
