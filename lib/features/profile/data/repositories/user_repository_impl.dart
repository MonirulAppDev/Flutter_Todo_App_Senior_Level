import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, UserEntity?>> getUser() async {
    try {
      final model = await localDataSource.getUser();
      if (model == null) return const Right(null);

      return Right(
        UserEntity(
          id: model.id,
          name: model.name,
          email: model.email,
          password: model.password,
          isRegistered: model.isRegistered,
          profileImageUrl: model.profileImageUrl,
        ),
      );
    } catch (e) {
      return Left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUser(UserEntity user) async {
    try {
      final model = UserModel()
        ..id = user.id
        ..name = user.name
        ..email = user.email
        ..password = user.password
        ..isRegistered = user.isRegistered
        ..profileImageUrl = user.profileImageUrl;
      await localDataSource.saveUser(model);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(e.toString()));
    }
  }
}
