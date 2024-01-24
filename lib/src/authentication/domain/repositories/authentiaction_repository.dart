import 'package:bloc_tdd_sample/core/utils/typedef.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/entities/user.dart';

abstract class AuthoenticationRepository {
  const AuthoenticationRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
