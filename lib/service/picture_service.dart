// lib/services/picture_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:treezoo_frontend/model/main_model.dart'; // 全モデルクラス
import 'package:treezoo_frontend/config/constants.dart'; // 定数クラス

class PictureService {
  static const String _baseUrl = '$apiServerHost/api/v1/picture';

  // /picture/animal/profile から取得したプロフィール写真を返す(1件取得)
  Future<AnimalProfilePicture?> fetchAnimalProfilePicture(int animalId) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/animal/profile/$animalId'));
      if (response.statusCode == 200) {
        return AnimalProfilePicture.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load picture: ${response.statusCode}');
      }
    } catch (e) {
      print('選択した動物のプロフィール写真取得に失敗しました: $e');
      return null;
    }
  }

  // /picture/animal/profiles から取得したプロフィール写真を返す(全件取得)
  Future<Map<int, AnimalProfilePicture>> fetchAnimalProfilePictures() async {
    final response = await http.get(Uri.parse('$_baseUrl/animal/profiles'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      // animalIdとそれに対応するプロフィール写真のMapとして返却

      return Map.fromIterable(data,
          key: (item) => item['animal_id'] as int,
          value: (item) =>
              AnimalProfilePicture.fromJson(item as Map<String, dynamic>));
    } else {
      throw Exception('家系図全体のプロフィール写真取得に失敗しました');
    }
  }
}
