// lib/widgets/node_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treezoo_frontend/model/main_model.dart';

import 'provider/main_provider.dart'; // Provider (isRightPaseOpenProvider) を定義している定義している

class FamilyTreeNode extends ConsumerWidget {
  // 動物の情報を受け取る
  final AnimalSummary node;

  // コンストラクタ
  const FamilyTreeNode({super.key, required this.node});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        // 右ペインを開く
        ref.read(isRightPaneOpenProvider.notifier).state = true;
        // クリックされた動物の情報を右ペインにセット
        ref.read(selectedAnimalProvider.notifier).state = node;
        // クリックされた動物のプロフィール写真を右ペインにセット
        final picture = await ref
            .read(pictureServiceProvider)
            .fetchAnimalProfilePicture(node.animalId);
        print(picture);
        ref.read(selectedAnimalPictureProvider.notifier).state = picture;
      },
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border.all(color: Theme.of(context).colorScheme.primary),
        //   borderRadius: BorderRadius.circular(5),
        // ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 動物の情報を最低限だけ表示する
            Text(node.animalName, style: Theme.of(context).textTheme.headline6),
            // Text('${node.species}・${node.age}歳・${node.gender}'),
            // Text('${node.currentZooName}'),

            // 動物のプロフィール写真を表示する
            Consumer(
              builder: (context, ref, child) {
                final picture = ref.watch(selectedAnimalPictureProvider);
                return picture != null && picture.pictureData != null
                    ? Image.memory(picture.pictureData)
                    : const Text('No Image');
              },
            )
          ],
        ),
      ),
    );
  }
}
