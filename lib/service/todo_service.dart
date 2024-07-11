//service class

import 'package:hive_demo/model/to_do_model.dart';
import 'package:hive_flutter/adapters.dart';

class ToDoSerivce {
//create an instance of box with type of our model class

  Box<ToDo>? _toDoBox;

  Future<void> openBox() async {
    _toDoBox = await Hive.openBox<ToDo>('todos');
  }

  Future<void> closeBox() async {
    await _toDoBox!.close();
  }

  //method to add todo
  Future<void> addToD0(ToDo todo) async {
    if (_toDoBox == null) {
      await openBox();
    }
    await _toDoBox!.add(todo);
  }

  //get all the todos
  Future<List<ToDo>> getToDos() async {
    if (_toDoBox == null) {
      await openBox();
    }
    return _toDoBox!.values.toList();
  }

  //update the todos
  Future<void> updateTodo(int index, ToDo todo) async {
    if (_toDoBox == null) {
      await openBox();
    }
    await _toDoBox!.putAt(index, todo);
  }

  //delete the todo
  Future<void> deleteToDo(int index) async {
    if (_toDoBox == null) {
      await openBox();
    }
    await _toDoBox!.deleteAt(index);
  }
}
