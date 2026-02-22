import 'package:isar/isar.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel?> getUser();
  Future<void> saveUser(UserModel user);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Isar isar;

  UserLocalDataSourceImpl(this.isar);

  @override
  Future<UserModel?> getUser() async {
    return await isar.userModels.where().findFirst();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await isar.writeTxn(() async {
      await isar.userModels.put(user);
    });
  }
}
