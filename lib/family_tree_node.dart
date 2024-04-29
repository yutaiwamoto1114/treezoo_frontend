// lib/widgets/node_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treezoo_frontend/model/main_model.dart';
import 'package:treezoo_frontend/theme/theme_provider.dart';

import 'provider/main_provider.dart'; // Provider (isRightPaseOpenProvider) を定義している定義している

class FamilyTreeNode extends ConsumerWidget {
  // 動物の情報を受け取る
  final Animal node;

  // コンストラクタ
  const FamilyTreeNode({Key? key, required this.node}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // 右ペインを開く
        ref.read(isRightPaneOpenProvider.notifier).state = true;
        // 選択されたノードの詳細を設定
        ref.read(selectedAnimalProvider.notifier).state = node;
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ref.watch(themeProvider).primaryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ノードには最低限の情報のみ表示し、クリック時に右ペインで詳細を補完する
            Text(node.name,
                style: Theme.of(context).textTheme.headlineMedium), // 動物の名前
          ],
        ),
      ),
    );
  }
}
