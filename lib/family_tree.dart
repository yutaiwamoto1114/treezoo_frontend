// lib/widgets/family_tree.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'family_tree_node.dart';
import 'model/main_model.dart';
import 'provider/main_provider.dart';

// 家系図全体を表示するウィジェット
class FamilyTree extends ConsumerWidget {
  const FamilyTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // familyTreeProviderからデータを取得
    // AysncValue は、非同期処理で発生するloading/error状態をハンドリングできるクラス
    final familyTree = ref.watch(familyTreeProvider);

    // .when: AsyncValueを取り出す際の書式。3状態に応じて表示を切り替えられる
    return familyTree.when(
      // data: ロード完了後の表示
      data: (animalsMap) {
        return ListView(
          children: animalsMap.values
              .map((animal) => FamilyTreeNode(node: animal))
              .toList(),
        );
      },
      // loading: ローディング中の表示
      loading: () => const Center(child: CircularProgressIndicator()),
      // error: ロード失敗時の表示
      error: (err, _) => Center(child: Text('エラーが発生しました: $err')),
    );
  }
}
