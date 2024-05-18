import 'package:flutter/material.dart';
import 'package:treezoo_frontend/provider/theme_provider.dart';
import 'right_pane.dart';
import 'left_pane.dart';
import 'family_tree.dart'; // 家系図ver1
import 'grid_family_tree.dart'; //家系図ver2
import 'family_tree_screen.dart'; // 家系図ver3
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider/main_provider.dart';

class MainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerから現在のテーマ取得
    final ThemeData theme = ref.watch(themeProvider);

    // 右ペインの開閉状態を取得
    final isRightPaneOpen = ref.watch(isRightPaneOpenProvider);

    // 左ペインの開閉状態を取得
    final isLeftPaneOpen = ref.watch(isLeftPaneOpenProvider);

    // InteractiveViewer領域の表示リセット用に、TransformationControllerを初期化
    final transformationController = TransformationController();

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
          // isLeftPaneOpenがtrueのときのみ、右ペインを表示
          isLeftPaneOpen ? LeftPane() : _buildLeftOpenButton(context, ref),

          // Expanded: RowやColumnのchildren要素として配置したウィジェットの隙間を埋める
          // つまり、今回はFamilyTreeとRightPaneが横いっぱいに拡大される

          /*
          // 家系図その1: とりあえず並べて表示してみる実装
          Expanded(
              child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(80),
            minScale: 0.1,
            maxScale: 5.0,
            transformationController: transformationController,
            child: FamilyTree(), // 家系図のメインコンテンツ,
          )),
          */

          // 家系図その2: Gridを利用した実装
          Expanded(
              child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(80),
            minScale: 0.1,
            maxScale: 5.0,
            transformationController: transformationController,
            child: GridFamilyTree(),
          )),

          // 家系図その3: GPT 4oによる実装
          Expanded(
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.all(80),
              minScale: 0.1,
              maxScale: 5.0,
              transformationController: transformationController,
              child: FamilyTreeScreen(rootAnimalId: 1),
            ),
          ),

          // isRightPaneOpenがtrueのときのみ、右ペインを表示
          isRightPaneOpen ? RightPane() : _buildOpenButton(context, ref),
        ],
      ),
      // InteractiveViewer表示リセットボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          transformationController.value = Matrix4.identity();
        },
        child: Icon(Icons.fullscreen),
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

  // 左ペインを開閉するボタン
  Widget _buildLeftOpenButton(BuildContext context, WidgetRef ref) {
    // 画面右端のすべてがクリック領域になるように、Column > Expanded として縦方向に伸ばす
    return Column(
      children: [
        Expanded(
          child: IconButton(
            icon: Icon(Icons.chevron_right), // 開くボタンのアイコン
            onPressed: () {
              // 右ペインの開閉状態をtrueにすることで、開かせる
              ref.read(isLeftPaneOpenProvider.notifier).state = true;
            },
          ),
        )
      ],
    );
  }
}
