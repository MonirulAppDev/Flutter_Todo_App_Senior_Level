import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class GetTodosByDate implements UseCase<List<TodoEntity>, DateTime> {
  final TodoRepository repository;

  GetTodosByDate(this.repository);

  @override
  Future<Either<Failure, List<TodoEntity>>> call(DateTime params) async {
    return await repository.getTodosByDate(params);
  }
}
