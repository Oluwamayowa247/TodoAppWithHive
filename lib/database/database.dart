import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List toDos = [];

  final _todoBox = Hive.box('todoBox');

  void createInitialData() {
    toDos = [
      ['Write NewSchDev Article', false],
      ['Make BreakFast', false],
    ];
  }

  void loadData() {
    toDos = _todoBox.get('TODOLIST');
  }

  void updateDatabase() {
    _todoBox.put("TODOLIST", toDos);
  }
}
