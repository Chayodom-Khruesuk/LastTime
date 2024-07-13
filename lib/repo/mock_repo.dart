import 'package:flutter_lasttime/model/item_action.dart';
import 'package:flutter_lasttime/repo/repo.dart';

class MockRepo extends Repo {
  @override
  Future<List<ItemAction>> load() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      const ItemAction(1, 'ส่งการบ้าน', 5, null),
      const ItemAction(2, 'กวาดบ้าน', 1, null),
      const ItemAction(3, 'เดินจงกลม', 2, null),
      const ItemAction(4, 'ซักผ้า', 10, null),
      const ItemAction(5, 'เปลี่ยนผ้าปูที่นอน', 6, null),
    ];
  }
}
