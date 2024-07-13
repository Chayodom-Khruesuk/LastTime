import 'package:flutter_lasttime/model/item_action.dart';
import 'package:flutter_lasttime/repo/repo.dart';

class MockRepo extends Repo {
  @override
  Future<List<ItemAction>> load() async {
    await Future.delayed(const Duration(seconds: 5));
    return [
      const ItemAction(1, 'Exercise LastTime', 5, null),
      const ItemAction(2, 'Commit item load ', 1, null),
      const ItemAction(3, 'Connected bloc with repository', 2, null),
      const ItemAction(4, 'Reproduct bloc can support load item', 10, null),
      const ItemAction(5, 'Prepare widget for load item', 6, null),
    ];
  }
}
