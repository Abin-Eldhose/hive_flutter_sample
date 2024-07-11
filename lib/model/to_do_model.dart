//title
//description
//complted
//createdat

import 'package:hive_flutter/adapters.dart';

part 'to_do_model.g.dart'; // content of this files are part of another file

@HiveType(typeId: 0)
class ToDo {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;
  @HiveField(2)
  late DateTime createdAt;
  @HiveField(3)
  late bool completed;

  ToDo({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.completed,
  });
}
