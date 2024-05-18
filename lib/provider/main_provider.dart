// lib/provider/main_provider.dart
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treezoo_frontend/model/main_model.dart';
import 'package:treezoo_frontend/service/family_service.dart';
import 'package:treezoo_frontend/service/picture_service.dart';

///////////////////////////
/// UI状態関連
///////////////////////////

// 右ペインの開閉状態を管理するProvider
final isRightPaneOpenProvider = StateProvider<bool>((ref) => true);

// 右ペインのサイズを管理するProvider
final rightPaneWidthProvider = StateProvider<double>((ref) => 300.0); // 初期幅300

// 右ペインの開閉状態を管理するProvider
final isLeftPaneOpenProvider = StateProvider<bool>((ref) => true);

// 右ペインのサイズを管理するProvider
final leftPaneWidthProvider = StateProvider<double>((ref) => 300.0); // 初期幅300

///////////////////////////
/// 家系図サービス関連
///////////////////////////

// バックエンドから取得した動物の情報をキャッシュとして保持するProvider
// final animalDetailsProvider = StateProvider<Map<String, Animal>>((ref) => {});

// 現在選択している動物の情報を保持するProvider
final selectedAnimalProvider = StateProvider<AnimalSummary?>((ref) => null);

// 家系図サービスのインスタンスを提供するProvider(家系図サービスに定義した関数を呼び出すためのインターフェース)
final familyServiceProvider = Provider<FamilyService>((ref) {
  return FamilyService();
});

// 家系図で表示する動物の一覧をMapとして保持する
final familyTreeProvider = FutureProvider<Map<int, AnimalSummary>>((ref) async {
  return ref.read(familyServiceProvider).fetchAnimalsWithRelations();
});

// 特定の動物IDを引数に取る家系図プロバイダー
final familyTreeProvider2 = FutureProvider.family<Map<int, AnimalSummary>, int>(
    (ref, rootAnimalId) async {
  final familyService = ref.read(familyServiceProvider);
  return familyService.fetchAnimalsWithRelationsByRootId(rootAnimalId);
});

// 特定の動物IDを引数に取る動物詳細プロバイダー
final animalDetailProvider =
    FutureProvider.family<AnimalSummary, int>((ref, animalId) async {
  final familyService = ref.read(familyServiceProvider);
  return familyService.fetchAnimalById(animalId);
});

// 特定の動物IDを引数に取る子供関係プロバイダー
final childRelationsProvider =
    FutureProvider.family<List<ParentChildRelation>, int>(
        (ref, rootAnimalId) async {
  final familyService = ref.read(familyServiceProvider);
  return familyService.fetchChildRelationsByRootId(rootAnimalId);
});

///////////////////////////
/// 写真サービス関連
///////////////////////////

// 写真サービスのインスタンスを提供するProvider
final pictureServiceProvider = Provider<PictureService>((ref) {
  return PictureService();
});

// 家系図で表示している動物のプロフィール写真の一覧をMapとして保持する
final familyTreeProfilePictureProvider =
    FutureProvider<Map<int, AnimalProfilePicture>>((ref) async {
  return ref.read(pictureServiceProvider).fetchAnimalProfilePictures();
});

// 現在選択している動物の写真をMapとして保持する
final selectedAnimalPictureProvider =
    StateProvider<AnimalProfilePicture?>((ref) => null);
