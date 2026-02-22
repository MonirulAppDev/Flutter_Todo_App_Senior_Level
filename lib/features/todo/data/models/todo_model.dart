import 'package:isar/isar.dart';

part 'todo_model.g.dart';

@collection
class TodoModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String title;

  late String description;

  @Index()
  late DateTime date;

  late bool isCompleted;

  late String category;

  late int colorCode;

  TodoModel();
}
