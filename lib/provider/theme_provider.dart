// /lib/theme/theme_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';

// テーマプロバイダー
// 外部から変更可能な状態はStateProviderで宣言する
final themeProvider = StateProvider((ref) {
  // 初期テーマを設定
  return TreeZooAppTheme.lightTheme; // ライトテーマ
  // return TreeZooAppTheme.darkTheme; // ダークテーマ
});
