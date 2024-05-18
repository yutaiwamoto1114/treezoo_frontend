import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider/main_provider.dart';
import 'model/main_model.dart';

class FamilyTreePainter extends CustomPainter {
  final Map<int, AnimalSummary> animals;
  final int rootAnimalId;

  FamilyTreePainter(this.animals, this.rootAnimalId);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    // ルートノードを描画
    _drawAnimalNode(canvas, rootAnimalId, size.width / 2, 50, paint, {});
  }

  void _drawAnimalNode(Canvas canvas, int animalId, double x, double y,
      Paint paint, Set<int> drawnNodes) {
    if (!animals.containsKey(animalId)) return;

    final animal = animals[animalId]!;
    if (drawnNodes.contains(animalId)) return; // 既に描画されたノードはスキップ
    drawnNodes.add(animalId);

    final textPainter = TextPainter(
      text: TextSpan(
        text: animal.animalName,
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y));

    // 親ノードを描画
    if (animal.parents.isNotEmpty) {
      final parentY = y - 100;
      double parentX = x - 100 * (animal.parents.length - 1);
      final parentMidX = (animal.parents.length > 1)
          ? (parentX + (parentX + 200 * (animal.parents.length - 1))) / 2
          : parentX;

      for (var parentId in animal.parents) {
        if (!animals.containsKey(parentId)) continue;

        final parent = animals[parentId]!;
        final parentTextPainter = TextPainter(
          text: TextSpan(
            text: parent.animalName,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          textDirection: TextDirection.ltr,
        );
        parentTextPainter.layout();
        parentTextPainter.paint(
            canvas, Offset(parentX - parentTextPainter.width / 2, parentY));

        canvas.drawLine(
            Offset(parentMidX, parentY + 20), Offset(x, y - 10), paint);

        _drawAnimalNode(canvas, parentId, parentX, parentY, paint, drawnNodes);
        parentX += 200;
      }

      // 親同士を結ぶ水平線
      if (animal.parents.length > 1) {
        canvas.drawLine(Offset(parentX - 200, parentY + 20),
            Offset(parentMidX, parentY + 20), paint);
      }
    }

    // 子ノードを描画
    if (animal.children.isNotEmpty) {
      final childY = y + 100;
      double childX = x - 100 * (animal.children.length - 1);
      final childMidX = (animal.children.length > 1)
          ? (childX + (childX + 200 * (animal.children.length - 1))) / 2
          : childX;

      for (var childId in animal.children) {
        if (!animals.containsKey(childId)) continue;

        final child = animals[childId]!;
        final childTextPainter = TextPainter(
          text: TextSpan(
            text: child.animalName,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          textDirection: TextDirection.ltr,
        );
        childTextPainter.layout();
        childTextPainter.paint(
            canvas, Offset(childX - childTextPainter.width / 2, childY));

        canvas.drawLine(
            Offset(x, y + 20), Offset(childMidX, childY - 10), paint);

        _drawAnimalNode(canvas, childId, childX, childY, paint, drawnNodes);
        childX += 200;
      }

      // 子同士を結ぶ水平線
      if (animal.children.length > 1) {
        canvas.drawLine(Offset(childMidX, childY - 10),
            Offset(childX - 200, childY - 10), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
