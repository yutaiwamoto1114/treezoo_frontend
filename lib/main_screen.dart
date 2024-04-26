import 'package:flutter/material.dart';
import 'package:treezoo_frontend/theme/theme_provider.dart';
import 'right_pane.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerから現在のテーマ取得
    final ThemeData theme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('TreeZoo'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.login),
              onPressed: () {
                // ログイン処理
              }),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // ログアウト処理
            },
          ),
        ],
        backgroundColor: theme.colorScheme.primary, // テーマのプライマリカラーを使用
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text('家系図アプリのメインコンテンツ'),
            ),
          ),
          RightPane(), // 右ペインを追加
        ],
      ),
    );
  }
}
