//to show all the todos
//add new todo
//edit todo
//mark as completed
//get all todos from your hvie to show the code

import 'package:flutter/material.dart';
import 'package:hive_demo/model/to_do_model.dart';
import 'package:hive_demo/service/todo_service.dart';

class ToDoHomeScreen extends StatefulWidget {
  const ToDoHomeScreen({super.key});

  @override
  State<ToDoHomeScreen> createState() => _ToDoHomeScreenState();
}

class _ToDoHomeScreenState extends State<ToDoHomeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  //create the instance of sevirceclass "ToDoServices"
  final ToDoSerivce _toDoSerivce = ToDoSerivce();

  //
  List<ToDo> _todo = [];

  //loading all todos(fetching all data from the hive)
  Future<void> _loadToDos() async {
    _todo = await _toDoSerivce.getToDos();
    setState(() {});
  }

  @override
  void initState() {
    _loadToDos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Tasks"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: _todo.isEmpty
            ? Center(child: Text("No tasks added"))
            : ListView.builder(
                itemCount: _todo.length,
                itemBuilder: (context, index) {
                  final todo = _todo[index];
                  return Card(
                    elevation: 3.0,
                    child: ListTile(
                        onTap: () {
                          //show edit dialouge
                          _showEditDialog(todo, index);
                        },
                        title: Text(todo.title),
                        subtitle: Text(todo.description),
                        leading: CircleAvatar(
                          child: Text("${index + 1}"),
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              await _toDoSerivce.deleteToDo(index);

                              //load the todos again
                              _loadToDos();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))),
                  );
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //dialog for adding a todo
          _showAdddDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAdddDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add new task"),
            content: Container(
              padding: const EdgeInsets.only(top: 30),
              height: 150,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Title"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Description"),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    //create a model for new todo
                    final newTodo = ToDo(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        createdAt: DateTime.now(),
                        completed: false);

                    await _toDoSerivce.addToD0(newTodo);
                    _titleController.clear();
                    _descriptionController.clear();
                    Navigator.pop(context);

                    _loadToDos();
                  },
                  child: const Text("Add")),
            ],
          );
        });
  }

  Future<void> _showEditDialog(ToDo todo, int index) async {
    _titleController.text = todo.title;
    _descriptionController.text = todo.description;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit task"),
            content: Container(
              padding: const EdgeInsets.only(top: 30),
              height: 150,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Title"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Description"),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    //create a model for new todo
                    todo.title = _titleController.text;
                    todo.description = _descriptionController.text;
                    await _toDoSerivce.updateTodo(index, todo);
                    _titleController.clear();
                    _descriptionController.clear();
                    Navigator.pop(context);

                    _loadToDos();
                  },
                  child: const Text("Update")),
            ],
          );
        });
  }
}
