import 'package:flutter_lasttime/model/item_action.dart';

abstract class Repo {
  Future<List<ItemAction>> load();
}
