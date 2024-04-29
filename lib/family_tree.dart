// lib/widgets/family_tree.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'family_tree_node.dart';

import 'model/main_model.dart';

class FamilyTree extends ConsumerWidget {
  final List<Animal> animals = [
    Animal(
        id: 1,
        name: 'Parent',
        species: 'Species A',
        birthday: DateTime.now(),
        age: 10,
        gender: 'male'),
    Animal(
        id: 2,
        name: 'Child 1',
        species: 'Species B',
        birthday: DateTime.now(),
        age: 5,
        gender: 'female'),
    Animal(
        id: 3,
        name: 'Child 2',
        species: 'Species C',
        birthday: DateTime.now(),
        age: 3,
        gender: 'male'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: animals.length,
      itemBuilder: (context, index) {
        return FamilyTreeNode(node: animals[index]);
      },
    );
  }
}
