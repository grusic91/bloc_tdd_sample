import 'package:bloc_tdd_sample/core/usecase/usecase.dart';
import 'package:bloc_tdd_sample/core/utils/typedef.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/entities/user.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/repositories/authentiaction_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthoenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
