import 'package:isar/isar.dart';
import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodosByDate(DateTime date);
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(int id);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Isar isar;

  TodoLocalDataSourceImpl(this.isar);

  @override
  Future<List<TodoModel>> getTodosByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return await isar.todoModels
        .filter()
        .dateBetween(startOfDay, endOfDay)
        .findAll();
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    await isar.writeTxn(() async {
      await isar.todoModels.put(todo);
    });
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await isar.writeTxn(() async {
      await isar.todoModels.put(todo);
    });
  }

  @override
  Future<void> deleteTodo(int id) async {
    await isar.writeTxn(() async {
      await isar.todoModels.delete(id);
    });
  }
}
