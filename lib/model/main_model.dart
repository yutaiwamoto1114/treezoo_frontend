// lib/model/main_model.dart
// すべてのmodelクラスをまとめて定義します

import 'dart:convert';
import 'dart:typed_data';

class Animal {
  final int id;
  final String name;
  final String species;
  final DateTime? birthday;
  final int? age;
  final String? gender;
  final Zoo? currentZoo;
  final List<int> parents;
  final List<int> children;

  Animal({
    required this.id,
    required this.name,
    required this.species,
    this.birthday,
    this.age,
    this.gender,
    this.currentZoo,
    required this.parents,
    required this.children,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['animal_id'] as int,
      name: json['name'] as String,
      species: json['species'] as String,
      birthday:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      currentZoo: json['current_zoo_id'] != null
          ? Zoo.fromJson(json['currentZoo'] as Map<String, dynamic>)
          : null,
      parents: List<int>.from(json['parents'] as List<dynamic>),
      children: List<int>.from(json['children'] as List<dynamic>),
    );
  }
}

class Zoo {
  final int id;
  final String name;
  final String location;

  Zoo({required this.id, required this.name, required this.location});

  factory Zoo.fromJson(Map<String, dynamic> json) {
    return Zoo(
      id: json['zoo_id'] as int,
      name: json['zoo_name'] as String,
      location: json['zoo_location'] as String,
    );
  }
}

class AnimalSummary {
  final int animalId;
  final String animalName;
  final String species;
  final DateTime? birthday;
  final int? age;
  final String? gender;
  final int? currentZooId;
  final String? currentZooName;
  final List<int> parents;
  final List<int> children;

  AnimalSummary({
    required this.animalId,
    required this.animalName,
    required this.species,
    this.birthday,
    this.age,
    this.gender,
    this.currentZooId,
    this.currentZooName,
    required this.parents,
    required this.children,
  });

  factory AnimalSummary.fromJson(Map<String, dynamic> json) {
    return AnimalSummary(
      animalId: json['animal_id'] as int,
      animalName: json['animal_name'] as String,
      species: json['species'] as String,
      birthday: json['birthday'] != null
          ? DateTime.parse(json['birthday'] as String)
          : null,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      currentZooId: json['current_zoo_id'] as int?,
      currentZooName: json['current_zoo_name'] as String?,
      parents: (json['parents'] as List).map<int>((e) => e as int).toList(),
      children: (json['children'] as List).map<int>((e) => e as int).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'animal_id': animalId,
      'animal_name': animalName,
      'species': species,
      'birthday': birthday?.toIso8601String(),
      'age': age,
      'gender': gender,
      'current_zoo_id': currentZooId,
      'current_zoo_name': currentZooName,
      'parents': parents,
      'children': children,
    };
  }
}

class AnimalProfilePicture {
  final int animalId;
  final int pictureId;
  final Uint8List pictureData;
  final String? description;
  final bool? isProfile;
  final int? priority;
  final DateTime? shootDate;
  final DateTime? uploadDate;

  AnimalProfilePicture({
    required this.animalId,
    required this.pictureId,
    required this.pictureData,
    this.description,
    this.isProfile,
    this.priority,
    this.shootDate,
    this.uploadDate,
  });

  factory AnimalProfilePicture.fromJson(Map<String, dynamic> json) {
    return AnimalProfilePicture(
      animalId: json['animal_id'],
      pictureId: json['picture_id'],
      pictureData: base64Decode(json['picture_data']),
      description: json['description'],
      isProfile: json['is_profile'],
      priority: json['priority'],
      shootDate: json['shoot_date'] != null
          ? DateTime.parse(json['shoot_date'])
          : null,
      uploadDate: json['upload_date'] != null
          ? DateTime.parse(json['upload_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'picture_id': pictureId,
      'picture_data': base64Encode(pictureData),
      'description': description,
      'is_profile': isProfile,
      'priority': priority,
      'shoot_date': shootDate?.toIso8601String(),
      'upload_date': uploadDate?.toIso8601String(),
    };
  }
}

class ParentChildRelation {
  final int childId;
  final int parentId;

  ParentChildRelation({
    required this.childId,
    required this.parentId,
  });

  factory ParentChildRelation.fromJson(Map<String, dynamic> json) {
    return ParentChildRelation(
        childId: json['child_id'], parentId: json['parent_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'child_id': childId,
      'parent_id': parentId,
    };
  }
}
