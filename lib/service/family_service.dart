// lib/services/family_service.dart
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:treezoo_frontend/model/main_model.dart'; // 全モデルクラス
import 'package:treezoo_frontend/config/constants.dart'; // 定数クラス

class FamilyService {
  static const String _baseUrl = '$apiServerHost/api/v1/family';

  // /family/animal/$animalId
  Future<AnimalSummary> fetchAnimalById(int animalId) async {
    final response = await http.get(Uri.parse('$_baseUrl/animal/$animalId'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return AnimalSummary.fromJson(data);
    } else {
      throw Exception('Failed to load animal');
    }
  }

  // /family/animals/relations から取得した動物情報リストをMapとして返却
  Future<Map<int, AnimalSummary>> fetchAnimalsWithRelations() async {
    final response = await http.get(Uri.parse('$_baseUrl/animals/relations'));

    if (response.statusCode == 200) {
      // バックエンドからの取得はJSONリストで行い、Map化はフロントエンドで行う
      List<dynamic> data = jsonDecode(response.body);
      return Map.fromIterable(data,
          key: (item) => item['animal_id'] as int,
          value: (item) =>
              AnimalSummary.fromJson(item as Map<String, dynamic>));
    } else {
      throw Exception('APIからのデータ取得に失敗しました。');
    }
  }

  Future<Map<int, AnimalSummary>> fetchAnimalsWithRelationsByRootId(
      int rootAnimalId) async {
    // APIから特定の動物を中心とした家系図を取得するロジック
    final response = await http.get(Uri.parse('$_baseUrl/tree/$rootAnimalId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      Map<int, AnimalSummary> animals = {};
      for (var item in data) {
        var animal = item as Map<String, dynamic>;
        animals[animal['animal_id']] = AnimalSummary.fromJson(animal);
      }
      return animals;
    } else {
      throw Exception('家系図の読み込みに失敗しました');
    }
  }

  Future<List<ParentChildRelation>> fetchChildRelationsByRootId(
      int rootAnimalId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/childrelations/$rootAnimalId'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => ParentChildRelation.fromJson(item)).toList();
    } else {
      throw Exception('child relationsの取得に失敗しました');
    }
  }
}
