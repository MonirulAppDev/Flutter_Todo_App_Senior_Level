import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodosByDate(
    DateTime date,
  ) async {
    try {
      final models = await localDataSource.getTodosByDate(date);
      final entities = models
          .map(
            (model) => TodoEntity(
              id: model.id,
              title: model.title,
              description: model.description,
              date: model.date,
              isCompleted: model.isCompleted,
              category: model.category,
              colorCode: model.colorCode,
            ),
          )
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addTodo(TodoEntity todo) async {
    try {
      final model = TodoModel()
        ..title = todo.title
        ..description = todo.description
        ..date = todo.date
        ..isCompleted = todo.isCompleted
        ..category = todo.category
        ..colorCode = todo.colorCode;
      await localDataSource.addTodo(model);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(TodoEntity todo) async {
    try {
      final model = TodoModel()
        ..id = todo.id
        ..title = todo.title
        ..description = todo.description
        ..date = todo.date
        ..isCompleted = todo.isCompleted
        ..category = todo.category
        ..colorCode = todo.colorCode;
      await localDataSource.updateTodo(model);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try {
      await localDataSource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(e.toString()));
    }
  }
}
