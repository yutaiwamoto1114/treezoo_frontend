// lib/provider/main_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treezoo_frontend/model/main_model.dart';
import '../service/family_service.dart';

// 右ペインの開閉状態を管理するProvider
final isRightPaneOpenProvider = StateProvider<bool>((ref) => true);

// 右ペインのサイズを管理するProvider
final rightPaneWidthProvider = StateProvider<double>((ref) => 300.0); // 初期幅300

// バックエンドから取得した動物の情報をキャッシュとして保持するProvider
final animalDetailsProvider = StateProvider<Map<String, Animal>>((ref) => {});

// 現在選択している動物の情報を保持するProvider
final selectedAnimalProvider = StateProvider<AnimalSummary?>((ref) => null);

final familyServiceProvider = Provider<FamilyService>((ref) {
  return FamilyService();
});

// 家系図で表示する動物の一覧をMapとして保持する
final familyTreeProvider = FutureProvider<Map<int, AnimalSummary>>((ref) async {
  return ref.read(familyServiceProvider).fetchAnimalsWithRelations();
});
