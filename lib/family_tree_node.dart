import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treezoo_frontend/model/main_model.dart';
import 'package:treezoo_frontend/provider/main_provider.dart';

// 動物のノード
class FamilyTreeNode extends ConsumerWidget {
  final AnimalSummary animal; // 動物のサマリ情報
  final AnimalProfilePicture? profilePicture; // 動物のプロフィール写真
  final double x; // ノードのx座標
  final double y; // ノードのy座標
  final double nodeSize; // ノードのサイズ

  const FamilyTreeNode({
    super.key,
    required this.animal,
    this.profilePicture,
    required this.x,
    required this.y,
    required this.nodeSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*
      Positioned: ウィジェットを任意に重ねて配置したいときに利用する
        GestureDetector: タッチ検出
    */
    return Positioned(
      left: x,
      top: y,
      child: GestureDetector(
        onTap: () async {
          print('Node tapped: ${animal.animalName}'); // デバッグ用のログ
          ref.read(isRightPaneOpenProvider.notifier).state = true;
          ref.read(selectedAnimalProvider.notifier).state = animal;
          ref.read(selectedAnimalPictureProvider.notifier).state = await ref
              .read(pictureServiceProvider)
              .fetchAnimalProfilePicture(animal.animalId);
        },
        child: Card(
          margin: EdgeInsets.all(0), // グリッドに合わせるために余白を消す
          elevation: 10, // 影の濃さ
          child: SizedBox(
            width: nodeSize,
            height: nodeSize,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  animal.animalName,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Expanded(
                  child: profilePicture != null
                      ? Image.memory(profilePicture!.pictureData,
                          fit: BoxFit.cover)
                      : Image.asset('assets/no_image_logo.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
