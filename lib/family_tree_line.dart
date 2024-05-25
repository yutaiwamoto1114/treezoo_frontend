import 'package:flutter/material.dart';

class FamilyTreeLine extends StatelessWidget {
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final double nodeSize;

  FamilyTreeLine({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.nodeSize,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: LinePainter(
        startX: startX + nodeSize / 2,
        startY: startY + nodeSize / 2,
        endX: endX + nodeSize / 2,
        endY: endY + nodeSize / 2,
      ),
    );
  }
}

// ノード同士を結ぶ線を描画する
class LinePainter extends CustomPainter {
  final double startX;
  final double startY;
  final double endX;
  final double endY;

  LinePainter({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    if (startX == endX) {
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    } else if (startY == endY) {
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    } else {
      throw Exception("家系図の線は水平または垂直である必要があります。");
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
