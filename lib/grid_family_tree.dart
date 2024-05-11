// lib/grid_family_tree.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'family_tree_node.dart'; // カスタムしたノード表示ウィジェット
import 'model/main_model.dart';
import 'provider/main_provider.dart';

class GridFamilyTree extends ConsumerWidget {
  final double cellWidth = 100; // グリッドのセルの幅
  final double cellHeight = 100; // グリッドのセルの高さ

  GridFamilyTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyTree = ref.watch(familyTreeProvider);

    return familyTree.when(
      data: (Map<int, AnimalSummary> animalsMap) {
        return GridView.count(
          crossAxisCount: 3, // 一行に3つのセルを配置
          childAspectRatio: cellWidth / cellHeight, // セルの比率を設定
          children: animalsMap.values.map((animal) {
            return Card(
              child: Center(
                child: FamilyTreeNode(node: animal), // 各動物をノードとして表示
              ),
            );
          }).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('エラーが発生しました: $err')),
    );
  }
}
