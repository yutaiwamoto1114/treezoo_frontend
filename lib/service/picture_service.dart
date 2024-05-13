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
        print(jsonDecode(response.body));
        return AnimalProfilePicture.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load picture: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching picture: $e');
      return null;
    }
  }
}
