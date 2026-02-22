import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos_by_date.dart';
import '../../domain/usecases/update_todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosByDate getTodosByDate;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  TodoBloc({
    required this.getTodosByDate,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
  }) : super(TodoInitial()) {
    on<GetTodosForDateEvent>(_onGetTodosForDate);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onGetTodosForDate(
    GetTodosForDateEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    final result = await getTodosByDate(event.date);
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) => emit(TodoLoaded(todos, event.date)),
    );
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    final result = await addTodo(event.todo);
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) => add(GetTodosForDateEvent(event.todo.date)),
    );
  }

  Future<void> _onUpdateTodo(
    UpdateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await updateTodo(event.todo);
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) => add(GetTodosForDateEvent(event.todo.date)),
    );
  }

  Future<void> _onDeleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    if (state is TodoLoaded) {
      final currentDate = (state as TodoLoaded).selectedDate;
      final result = await deleteTodo(event.id);
      result.fold(
        (failure) => emit(TodoError(failure.message)),
        (_) => add(GetTodosForDateEvent(currentDate)),
      );
    }
  }
}
