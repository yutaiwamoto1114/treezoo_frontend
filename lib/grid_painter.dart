import 'package:flutter/material.dart';

// キャンバス上に水平線と垂直線で構成されたグリッドを描画するウィジェット
class GridPainter extends CustomPainter {
  // paintメソッド: 描画を行う
  @override
  void paint(Canvas canvas, Size size) {
    // グリッド線の色と太さを指定
    final paint = Paint()
      ..color = Color(0xFFE0E0E0)
      ..strokeWidth = 0.5;

    // 垂直線を100px間隔で描画
    for (double x = 0; x <= size.width; x += 100) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // 水平線を100px間隔で描画
    for (double y = 0; y <= size.height; y += 100) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  // shouldRepaintメソッド: ペインターが再描画されるべきかどうか
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
