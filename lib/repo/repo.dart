import 'package:flutter_lasttime/model/item_action.dart';

abstract class Repo {
  Future<List<ItemAction>> load();
  Future<List<ItemAction>> loadWithDelay();
  Future<void> remove({required int id});
  Future<void> add({required String name, required int cycleDateTime});
  Future<void> update({required int id, required DateTime? action});
}
