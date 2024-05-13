// lib/widgets/node_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treezoo_frontend/model/main_model.dart';

import 'provider/main_provider.dart'; // Provider (isRightPaseOpenProvider) を定義している定義している

class FamilyTreeNode extends ConsumerWidget {
  // 動物の情報を受け取る
  final AnimalSummary animal;
  // 動物のプロフィール写真を受け取る
  final AnimalProfilePicture profilePicture;

  // コンストラクタ
  const FamilyTreeNode(
      {super.key, required this.animal, required this.profilePicture});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () async {
          // 右ペインを開く
          ref.read(isRightPaneOpenProvider.notifier).state = true;
          // クリックされた動物の情報を右ペインにセット
          ref.read(selectedAnimalProvider.notifier).state = animal;
          // クリックされた動物のプロフィール写真を右ペインにセット
          // ここはthis.profilePictureをバケツリレーしてもいいけど、まあAPIから再取得しとくか
          ref.read(selectedAnimalPictureProvider.notifier).state = await ref
              .read(pictureServiceProvider)
              .fetchAnimalProfilePicture(animal.animalId);
        },
        // ノードには動物の名前とプロフィール写真を表示する
        child: Card(
          elevation: 10, // カードに影をつける
          child: AspectRatio(
            aspectRatio: 1 / 1, // 全体のアスペクト比を1:1に設定
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 動物の名前を表示
                Text(
                  animal.animalName,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                // 動物のプロフィール写真を表示
                Expanded(
                  child: profilePicture != null
                      ? Image.memory(profilePicture.pictureData,
                          fit: BoxFit.cover)
                      : Image.asset('lib/asset/no_image_logo.png'),
                ),
              ],
            ),
          ),
        ));
  }
}
