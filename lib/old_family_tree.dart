// lib/grid_family_tree.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'old_family_tree_node.dart'; // カスタムしたノード表示ウィジェット
import 'model/main_model.dart';
import 'provider/main_provider.dart';
import 'dart:typed_data';

class OldGridFamilyTree extends ConsumerWidget {
  final double cellWidth = 100; // グリッドのセルの幅
  final double cellHeight = 100; // グリッドのセルの高さ

  OldGridFamilyTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyTree = ref.watch(familyTreeProvider);

    return familyTree.when(
      data: (Map<int, AnimalSummary> animalsMap) {
        return GridView.count(
          crossAxisCount: 3, // 一行に3つのセルを配置
          childAspectRatio: cellWidth / cellHeight, // セルの比率を設定
          children: animalsMap.values.map((animal) {
            return FutureBuilder<AnimalProfilePicture?>(
              future: ref
                  .read(pictureServiceProvider)
                  .fetchAnimalProfilePicture(animal.animalId),
              builder: (context, snapshot) {
                // データ取得中にプログレスインジケータを表示
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Card(
                      child: Center(child: CircularProgressIndicator()));
                }
                if (snapshot.hasError) {
                  return Card(child: Center(child: Text('画像の取得に失敗しました')));
                }
                final profilePicture = snapshot.data;
                return FamilyTreeNodeOld(
                  animal: animal,
                  profilePicture: profilePicture ??
                      AnimalProfilePicture(
                        pictureId: 0,
                        pictureData: Uint8List(0), // エラー時のプレースホルダー
                        animalId: animal.animalId,
                      ),
                );
              },
            );
          }).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('エラーが発生しました: $err')),
    );
  }
}
