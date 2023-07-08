import 'package:hive_flutter/hive_flutter.dart';

final db = Database();

class Database {
  late final Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('todoBox');
  }

  List getTodoItems() {
    return _box.get('todoList') ?? [];
  }

  void updateTodoList(List list) {
    _box.put('todoList', list);
  }
}
