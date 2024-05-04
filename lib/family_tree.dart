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
    final familyTree = ref.watch(familyTreeProvider);

    return familyTree.when(
      data: (animalsMap) {
        return ListView(
          children: animalsMap.values
              .map((animal) => FamilyTreeNode(node: animal))
              .toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('エラーが発生しました: $err')),
    );
  }
}
