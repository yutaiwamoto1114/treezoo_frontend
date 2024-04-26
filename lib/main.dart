// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treezoo_frontend/main_screen.dart';
import 'package:treezoo_frontend/theme/theme_provider.dart';

import 'theme/app_theme.dart';

void main() {
  // ProviderScopeでアプリケーション全体をラップすることで、アプリ全体がRiverpodで状態管理される
  runApp(ProviderScope(child: TreeZooApp()));
}

class TreeZooApp extends ConsumerWidget {
  const TreeZooApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // テーマプロバイダーから現在のテーマを取得
    final ThemeData currentTheme = ref.watch(themeProvider);

    return MaterialApp(
      title: 'TreeZooApp',
      theme: currentTheme,
      home: MainScreen(),
    );
  }
}
