import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive_app/components/dialog_box.dart';
import 'package:todo_hive_app/components/todo_tile.dart';
import 'package:todo_hive_app/database/database.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
//reference hive box
  final _todoBox = Hive.box('todoBox');

  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if (_todoBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDos[index][1] = !db.toDos[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.toDos.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            onCancel: (() => Navigator.of(context).pop()),
            onSave: saveNewTask,
            controller: _controller,
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDos.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text(
            'TO DO APP',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: 'Quicksand'),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        body: ListView.builder(
          itemCount: db.toDos.length,
          itemBuilder: (BuildContext context, int index) {
            return ToDoTile(
              deleteFunction: ((context) => deleteTask(index)),
              taskName: db.toDos[index][0],
              taskCompleted: db.toDos[index][1],
              onChanged: ((value) {
                return checkBoxChanged(value, index);
              }),
            );
          },
        ),
      ),
    );
  }
}
