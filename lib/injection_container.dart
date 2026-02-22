import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/profile/data/models/user_model.dart';
import 'features/profile/data/repositories/user_repository_impl.dart';
import 'features/profile/domain/repositories/user_repository.dart';
import 'features/profile/domain/usecases/get_user.dart';
import 'features/profile/domain/usecases/save_user.dart';
import 'features/profile/domain/usecases/login_user.dart';
import 'features/profile/domain/usecases/register_user.dart';
import 'features/todo/data/datasources/todo_local_data_source.dart';
import 'features/todo/data/models/todo_model.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/domain/repositories/todo_repository.dart';
import 'features/todo/domain/usecases/add_todo.dart';
import 'features/todo/domain/usecases/delete_todo.dart';
import 'features/todo/domain/usecases/get_todos_by_date.dart';
import 'features/todo/domain/usecases/update_todo.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';
import 'features/profile/data/datasources/user_local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  // Blocs
  sl.registerFactory(
    () => TodoBloc(
      getTodosByDate: sl(),
      addTodo: sl(),
      updateTodo: sl(),
      deleteTodo: sl(),
    ),
  );
  sl.registerFactory(
    () => ProfileBloc(
      getUser: sl(),
      saveUser: sl(),
      loginUser: sl(),
      registerUser: sl(),
    ),
  );

  // Use cases - Todo
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => GetTodosByDate(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));

  // Use cases - Profile
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => SaveUser(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sl()),
  );

  //! External
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([
    TodoModelSchema,
    UserModelSchema,
  ], directory: dir.path);
  sl.registerLazySingleton(() => isar);
}
