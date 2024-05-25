// /lib/family_tree_screen.dart
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'family_tree_node.dart';
// import 'family_tree_line.dart';
import 'provider/main_provider.dart';
import 'model/main_model.dart';
import 'grid_painter.dart';

// 家系図を表示する領域
class FamilyTreeScreen extends ConsumerWidget {
  final double nodeSize = 200.0; // ノードのサイズ

  const FamilyTreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyTree =
        ref.watch(familyTreeProviderById(1)); // サンプルデータのルートIDを1とする

    return familyTree.when(
      data: (data) {
        // データが空でないことを確認
        if (data.isEmpty) {
          return Center(child: Text('家系図データがありません。'));
        }

        // 動物データの位置を一括で計算
        final positions = _calculateNodePositions(data);

        /*
          CustomPaint: painterに指定したCustomPainterの、paintメソッドを暗黙的に呼び出す
            paintメソッドの呼び出しに必要なCanvasとSizeは自動的に与えられる
        */
        return CustomPaint(
          size: Size.infinite,
          painter: GridPainter(),
          child: Stack(
            children: [
              // // ラインを配置
              // for (var relation in data.values)
              //   for (var parentId in relation.parents)
              //     if (positions[parentId] != null) // null チェック
              //       FamilyTreeLine(
              //         startX: positions[parentId]!.dx,
              //         startY: positions[parentId]!.dy,
              //         endX: positions[relation.animalId]!.dx,
              //         endY: positions[relation.animalId]!.dy,
              //         nodeSize: nodeSize,
              //       ),
              // ノードを配置
              for (var entry in positions.entries)
                if (data[entry.key] != null) // null チェック

                  FutureBuilder<AnimalProfilePicture?>(
                    future: ref
                        .read(pictureServiceProvider)
                        .fetchAnimalProfilePicture(entry.key),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Card(
                            child: Center(child: CircularProgressIndicator()));
                      }
                      if (snapshot.hasError) {
                        return Card(child: Center(child: Text('画像の取得に失敗しました')));
                      }
                      final profilePicture = snapshot.data;
                      debugPrint(
                          'id: ${entry.key}, position: (${entry.value.dx}, ${entry.value.dy})');
                      return FamilyTreeNode(
                        animal: data[entry.key]!,
                        profilePicture: profilePicture ??
                            AnimalProfilePicture(
                              pictureId: 0,
                              pictureData: Uint8List(0), // エラー時のプレースホルダー
                              animalId: entry.key,
                            ),
                        x: entry.value.dx,
                        y: entry.value.dy,
                        nodeSize: nodeSize,
                      );
                    },
                  ),
            ],
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  // 各動物IDに対して、Offset(x座標とy座標)を計算する
  Map<int, Offset> _calculateNodePositions(Map<int, AnimalSummary> data) {
    Map<int, Offset> positions = {}; // 動物IDに対する座標を保持するマップ
    Map<int, int> levels = {}; // 動物IDに対するレベルを保持するマップ
    _calculateLevels(data, 1, 0, levels); // ノードのレベルを再帰的に計算

    // レベルの最大値(家系図の高さ)を取得
    // int maxLevel = levels.values.reduce((a, b) => a > b ? a : b);

    // どのレベルにいくつのノードが存在するか計算
    Map<int, int> levelCounts = {};
    for (var level in levels.values) {
      levelCounts[level] = (levelCounts[level] ?? 0) + 1;
    }

    // 各レベルにある各ノード(entry)の位置を計算
    for (var entry in levels.entries) {
      int id = entry.key; // 動物ID
      int level = entry.value; // レベル

      // そのレベル内でのインデックスを取得
      int index = levelCounts[level]!;

      // ノードの位置を計算
      positions[id] = Offset(index * nodeSize * 2, level * nodeSize * 2);

      // そのレベル内でのインデックスを更新
      levelCounts[level] = levelCounts[level]! - 1;
    }

    return positions;
  }

  // ノードのレベルを再帰的に計算し、levelsマップに格納する
  void _calculateLevels(
      Map<int, AnimalSummary> data, int id, int level, Map<int, int> levels) {
    // 既にレベル計算が済んでいるならばスキップ
    if (levels.containsKey(id)) return;

    // 計算結果を保存
    levels[id] = level;

    // 各子について、再帰的にレベルを計算 (子はレベルが+1される)
    for (var childId in data[id]!.children) {
      _calculateLevels(data, childId, level + 1, levels);
    }
  }
}
