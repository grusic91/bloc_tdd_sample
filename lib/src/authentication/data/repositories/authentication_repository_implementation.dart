import 'package:bloc_tdd_sample/core/errors/exceptions.dart';
import 'package:bloc_tdd_sample/core/errors/failure.dart';
import 'package:bloc_tdd_sample/core/utils/typedef.dart';
import 'package:bloc_tdd_sample/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/entities/user.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/repositories/authentiaction_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImplementation
    implements AuthoenticationRepository {
  // inject remoteDataSource into a class (dependecy injection)
  const AuthenticationRepositoryImplementation(this._remoteDataSource);
  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // call the remote data source
    // check if the method returns the proper data
    // // check if when the remoteDataSoruce throws an exception, we return a
    // failure and if it doesn't throw an exception, we return the actual
    // expected data
    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    // call the remote data source
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
