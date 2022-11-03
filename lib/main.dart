import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive_app/pages/todo_home.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('todoBox');
  runApp(HiveTodoApp());

  //creating boxes with Hive
}

class HiveTodoApp extends StatefulWidget {
  const HiveTodoApp({super.key});

  @override
  State<HiveTodoApp> createState() => _HiveTodoAppState();
}

class _HiveTodoAppState extends State<HiveTodoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoHome(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
