import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}

class LoginUser implements UseCase<UserEntity, LoginParams> {
  final UserRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    final userResult = await repository.getUser();
    return userResult.fold((failure) => Left(failure), (user) {
      if (user != null &&
          user.isRegistered &&
          user.email == params.email &&
          user.password == params.password) {
        return Right(user);
      } else {
        return const Left(ValidationFailure('Invalid email or password'));
      }
    });
  }
}
