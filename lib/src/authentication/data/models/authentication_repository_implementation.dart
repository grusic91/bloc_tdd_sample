import 'package:bloc_tdd_sample/core/utils/typedef.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/entities/user.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/repositories/authentiaction_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthoenticationRepository {
  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) {
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<User>> getUsers() {
    throw UnimplementedError();
  }
}
