// lib/services/family_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/main_model.dart'; // Animal モデルクラス

class FamilyService {
  static const String _baseUrl = 'http://localhost:8080/api/v1/family';

  // /family/animals/relations から取得した動物情報リストをMapとして返却
  Future<Map<int, AnimalSummary>> fetchAnimalsWithRelations() async {
    final response = await http.get(Uri.parse('$_baseUrl/animals/relations'));

    if (response.statusCode == 200) {
      // バックエンドからの取得はJSONリストで行う
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
