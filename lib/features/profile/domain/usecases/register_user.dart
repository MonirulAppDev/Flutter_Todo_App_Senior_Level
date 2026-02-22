import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class RegisterUser implements UseCase<void, UserEntity> {
  final UserRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, void>> call(UserEntity params) async {
    return await repository.saveUser(params);
  }
}
