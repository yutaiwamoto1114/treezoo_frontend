// lib/services/family_service.dart
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:treezoo_frontend/model/main_model.dart'; // 全モデルクラス
import 'package:treezoo_frontend/config/constants.dart'; // 定数クラス

class FamilyService {
  static const String _baseUrl = '$apiServerHost/api/v1/family';

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
}
