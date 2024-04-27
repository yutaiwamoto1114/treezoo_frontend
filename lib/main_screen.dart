import 'package:flutter/material.dart';
import 'package:treezoo_frontend/theme/theme_provider.dart';
import 'right_pane.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerから現在のテーマ取得
    final ThemeData theme = ref.watch(themeProvider);

    // 右ペインの開閉状態を取得
    final isRightPaneOpen = ref.watch(isRightPaneOpenProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TreeZoo'),
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
          const Expanded(
            child: Center(
              child: Text('家系図アプリのメインコンテンツ'),
            ),
          ),
          isRightPaneOpen
              ? RightPane()
              : _buildOpenButton(context, ref), // 右ペインを追加
        ],
      ),
    );
  }

  // 右ペインを開閉するボタン
  Widget _buildOpenButton(BuildContext context, WidgetRef ref) {
    // 画面右端のすべてがクリック領域になるように、Column > Expanded として縦方向に伸ばす
    return Column(
      children: [
        Expanded(
          child: IconButton(
            icon: Icon(Icons.chevron_left), // 開くボタンのアイコン
            onPressed: () {
              // 右ペインの開閉状態をtrueにすることで、開かせる
              ref.read(isRightPaneOpenProvider.notifier).state = true;
            },
          ),
        )
      ],
    );
  }
}
