// family_tree_screen.dart

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

    _drawAnimalNode(canvas, rootAnimalId, size.width / 2, 50, paint);
  }

  void _drawAnimalNode(
      Canvas canvas, int animalId, double x, double y, Paint paint) {
    if (!animals.containsKey(animalId)) return;

    final animal = animals[animalId]!;
    final textPainter = TextPainter(
      text: TextSpan(
        text: animal.animalName,
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y));

    final childOffsetY = y + 100;

    if (animal.parents.isNotEmpty) {
      double parentOffsetX = x - 100 * (animal.parents.length - 1) / 2;
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
        parentTextPainter.paint(canvas,
            Offset(parentOffsetX - parentTextPainter.width / 2, y - 100));

        canvas.drawLine(
            Offset(parentOffsetX, y - 100 + 10), Offset(x, y - 10), paint);
        parentOffsetX += 200;
      }
    }

    double childOffsetX = x - 100 * (animal.children.length - 1) / 2;
    for (var childId in animal.children) {
      if (!animals.containsKey(childId)) continue;

      canvas.drawLine(
          Offset(x, y + 10), Offset(childOffsetX, childOffsetY - 10), paint);
      _drawAnimalNode(canvas, childId, childOffsetX, childOffsetY, paint);
      childOffsetX += 200;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class FamilyTreeScreen extends ConsumerWidget {
  final int rootAnimalId;

  FamilyTreeScreen({required this.rootAnimalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyTreeAsyncValue = ref.watch(familyTreeProvider2(rootAnimalId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Family Tree'),
      ),
      body: familyTreeAsyncValue.when(
        data: (familyTree) => CustomPaint(
          size: Size(double.infinity, double.infinity),
          painter: FamilyTreePainter(familyTree, rootAnimalId),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
