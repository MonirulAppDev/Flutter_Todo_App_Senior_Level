import 'package:equatable/equatable.dart';
import '../../domain/entities/todo_entity.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class GetTodosForDateEvent extends TodoEvent {
  final DateTime date;
  const GetTodosForDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class AddTodoEvent extends TodoEvent {
  final TodoEntity todo;
  const AddTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class UpdateTodoEvent extends TodoEvent {
  final TodoEntity todo;
  const UpdateTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final int id;
  const DeleteTodoEvent(this.id);

  @override
  List<Object?> get props => [id];
}
