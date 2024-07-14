import 'package:flutter_lasttime/model/item_action.dart';
import 'package:flutter_lasttime/repo/repo.dart';

class MockRepo extends Repo {
  List<ItemAction> item = [
    const ItemAction(1, 'ส่งการบ้าน', 5, null),
    const ItemAction(2, 'กวาดบ้าน', 1, null),
    const ItemAction(3, 'เดินจงกลม', 2, null),
    const ItemAction(4, 'ซักผ้า', 10, null),
    const ItemAction(5, 'เปลี่ยนผ้าปูที่นอน', 6, null),
  ];

  @override
  Future<List<ItemAction>> loadWithDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    return item;
  }

  @override
  Future<void> remove({required int id}) async {
    await Future.delayed(const Duration());
    item.removeWhere((item) => item.id == id);
  }

  @override
  Future<List<ItemAction>> load() async {
    await Future.delayed(const Duration());
    return item;
  }

  @override
  Future<void> add({required String name, required int cycleDateTime}) async {
    await Future.delayed(const Duration());
    item.add(ItemAction(item.length + 1, name, cycleDateTime, null));
  }

  @override
  Future<void> update({required int id, required DateTime? action}) async {
    await Future.delayed(const Duration());
    final index = item.indexWhere((item) => item.id == id);
    item[index] =
        ItemAction(id, item[index].name, item[index].cycleDateTime, action);
  }
}
