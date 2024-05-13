import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/main_provider.dart';
import 'model/main_model.dart';

// 右ペインウィジェット
// Providerから状態を取得するのでConsumerWidgetとして定義
class RightPane extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpen = ref.watch(isRightPaneOpenProvider); // 開閉状態
    final currentWidth = ref.watch(rightPaneWidthProvider); // 現在の幅

    // 将来的にペインの幅を調整できるようにしたい
    final screenWidth = MediaQuery.of(context).size.width; // 画面幅
    final maxPaneWidth = screenWidth * 0.4; // 最大幅を画面幅の40%に制限

    // 現在選択されている動物の情報
    final AnimalSummary? animal = ref.watch(selectedAnimalProvider);

    // AnimatedContainer: アニメーションをつけるContainer
    return isOpen
        ? AnimatedContainer(
            // duration: アニメーションの長さ
            duration: Duration(milliseconds: 2000),
            width: currentWidth, // 幅調整
            color: Colors.grey[100], // ペインの背景色を設定
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // コンテンツを左寄せに設定
              children: [
                Align(
                  // Align: 親要素のalignとは無関係にchildの要素を整列する
                  alignment: Alignment.topRight, // 右上に配置
                  child: IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () => ref
                        .read(isRightPaneOpenProvider.notifier)
                        .state = false,
                  ),
                ),
                Expanded(
                  child: animal != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${animal.animalName}',
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                            Text('種族: ${animal.species}'),
                            Text('${animal.age} 歳 ${animal.gender}'),
                            // 動物のプロフィール写真を表示する
                            Consumer(
                              builder: (context, ref, child) {
                                final picture =
                                    ref.watch(selectedAnimalPictureProvider);
                                return picture != null &&
                                        picture.pictureData != null
                                    ? Image.memory(picture.pictureData)
                                    : const Text('No Image');
                              },
                            )
                          ],
                        )
                      : Text('動物を選択すると詳細がここに表示されます'),
                ),
              ],
            ))
        : SizedBox();
  }
}
