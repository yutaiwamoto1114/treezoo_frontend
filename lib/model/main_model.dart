// lib/models/animal.dart

// 動物クラス
class Animal {
  final int id;
  final String name;
  final String species;
  final DateTime? birthday;
  final int? age;
  final String? gender;
  final Zoo? birthZoo;
  final Zoo? currentZoo;

  // コンストラクタ
  Animal({
    required this.id,
    required this.name,
    required this.species,
    this.birthday,
    this.age,
    this.gender,
    this.birthZoo,
    this.currentZoo,
  });

  // fromJsonによって、json形式をvalueに変換する
  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['animal_id'] as int,
      name: json['name'] as String,
      species: json['species'] as String,
      birthday:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      birthZoo:
          json['birth_zoo_id'] != null ? Zoo.fromJson(json['birthZoo']) : null,
      currentZoo: json['current_zoo_id'] != null
          ? Zoo.fromJson(json['currentZoo'])
          : null,
    );
  }
}

// 動物園クラス
class Zoo {
  final int id;
  final String name;
  final String location;

  Zoo({required this.id, required this.name, required this.location});

  factory Zoo.fromJson(Map<String, dynamic> json) {
    return Zoo(
      id: json['zoo_id'] as int,
      name: json['name'] as String,
      location: json['location'] as String,
    );
  }
}
