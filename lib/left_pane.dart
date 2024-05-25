import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/main_provider.dart';

// 右ペインウィジェット
// Providerから状態を取得するのでConsumerWidgetとして定義
class LeftPane extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpen = ref.watch(isLeftPaneOpenProvider); // 開閉状態
    final currentWidth = ref.watch(leftPaneWidthProvider); // 現在の幅

    // 将来的にペインの幅を調整できるようにしたい
    // final screenWidth = MediaQuery.of(context).size.width; // 画面幅
    // final maxPaneWidth = screenWidth * 0.4; // 最大幅を画面幅の40%に制限

    // 検索条件
    // final AnimalSummary? animal = ref.watch(selectedAnimalProvider);

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
                  alignment: Alignment.topLeft, // 右上に配置
                  child: IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () =>
                        ref.read(isLeftPaneOpenProvider.notifier).state = false,
                  ),
                ),
                Expanded(
                  child: Text('検索条件などが表示されます'),
                ),
              ],
            ))
        : SizedBox();
  }
}
