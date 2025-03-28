import 'package:flutter/material.dart';
import 'package:hive_demo/model/to_do_model.dart';
import 'package:hive_demo/screens/todo/todohome_screen.dart';
import 'package:hive_demo/service/todo_service.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());

  //open a box in hive
  await ToDoSerivce().openBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ToDoHomeScreen(),
    );
  }
}
