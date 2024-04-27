import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 右ペインの開閉状態を管理するProvider
final isRightPaneOpenProvider = StateProvider<bool>((ref) => true);

// 右ペインのサイズを管理するProvider
final rightPaneWidthProvider = StateProvider<double>((ref) => 300.0); // 初期幅300

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

    // AnimatedContainer: アニメーションをつけるContainer
    return isOpen
        ? AnimatedContainer(
            // duration: アニメーションの長さ
            duration: Duration(milliseconds: 2300),
            width: currentWidth, // 幅調整
            color: Colors.grey[200], // ペインの背景色を設定
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end, // コンテンツを右寄せに設定
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () =>
                      ref.read(isRightPaneOpenProvider.notifier).state = false,
                  alignment: Alignment.topRight, // ボタンを右上に配置
                ),
                Expanded(
                  child: Center(
                    child: Text("詳細情報が表示されます"),
                  ),
                ),
              ],
            ))
        : SizedBox();
  }
}
