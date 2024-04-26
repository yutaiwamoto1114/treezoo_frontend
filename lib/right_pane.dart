import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// パネルの開閉状態
final isPaneOpenProvider = StateProvider<bool>((ref) => true);

// 右ペインウィジェット
class RightPane extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPaneOpen = ref.watch(isPaneOpenProvider);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: isPaneOpen ? 300 : 0, // 幅調整
      child: isPaneOpen
          ? Column(
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () =>
                      ref.read(isPaneOpenProvider.notifier).state = false,
                ),
                Expanded(
                  child: Center(
                    child: Text("詳細情報が表示されます"),
                  ),
                ),
              ],
            )
          : SizedBox(),
    );
  }
}
