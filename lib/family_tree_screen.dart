// /lib/family_tree_screen.dart
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'family_tree_node.dart';
import 'family_tree_line.dart';
import 'provider/main_provider.dart';
import 'model/main_model.dart';
import 'grid_painter.dart';

class FamilyTreeScreen extends ConsumerWidget {
  final double nodeSize = 200.0;

  const FamilyTreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyTree = ref.watch(familyTreeProvider2(1)); // サンプルデータのルートIDを1とする

    return familyTree.when(
      data: (data) {
        // データが空でないことを確認
        if (data.isEmpty) {
          return Center(child: Text('家系図データがありません。'));
        }

        final positions = _calculateNodePositions(data);

        return CustomPaint(
          size: Size.infinite,
          painter: GridPainter(),
          child: Stack(
            children: [
              // ノードとラインを配置
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
              for (var relation in data.values)
                for (var parentId in relation.parents)
                  if (positions[parentId] != null) // null チェック
                    FamilyTreeLine(
                      startX: positions[parentId]!.dx,
                      startY: positions[parentId]!.dy,
                      endX: positions[relation.animalId]!.dx,
                      endY: positions[relation.animalId]!.dy,
                      nodeSize: nodeSize,
                    ),
            ],
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Map<int, Offset> _calculateNodePositions(Map<int, AnimalSummary> data) {
    Map<int, Offset> positions = {};
    Map<int, int> levels = {};
    _calculateLevels(data, 1, 0, levels);

    // 計算するための最大レベルとそのノード数を求める
    int maxLevel = levels.values.reduce((a, b) => a > b ? a : b);
    Map<int, int> levelCounts = {};
    for (var level in levels.values) {
      levelCounts[level] = (levelCounts[level] ?? 0) + 1;
    }

    // 各レベルのノードを配置
    for (var entry in levels.entries) {
      int id = entry.key;
      int level = entry.value;
      int index = levelCounts[level]!;
      positions[id] = Offset(index * nodeSize * 2, level * nodeSize * 2);
      levelCounts[level] = levelCounts[level]! - 1;
    }

    return positions;
  }

  void _calculateLevels(
      Map<int, AnimalSummary> data, int id, int level, Map<int, int> levels) {
    if (levels.containsKey(id)) return;
    levels[id] = level;

    for (var childId in data[id]!.children) {
      _calculateLevels(data, childId, level + 1, levels);
    }
  }
}
