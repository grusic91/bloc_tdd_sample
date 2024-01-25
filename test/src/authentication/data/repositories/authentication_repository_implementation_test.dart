import 'package:bloc_tdd_sample/core/errors/exceptions.dart';
import 'package:bloc_tdd_sample/core/errors/failure.dart';
import 'package:bloc_tdd_sample/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:bloc_tdd_sample/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  // Test-Driven Development
  // call the remote data source
  // make sure that it returns the proper data if there is no exception
  // check if the method returns the proper data
  // // check if when the remoteDataSoruce throws an exception, we return a
  // failure and if it doesn't throw an exception, we return the actual
  // expected data

  const tException = APIException(
    message: 'Unknown Error Occourd',
    statusCode: 500,
  );

  group('createUser', () {
    const String createdAt = 'wathever.createdAt';
    const String name = 'wathever.name';
    const String avatar = 'wathever.avatar';
    test(
        'should call the [RemoteDataSource.createUser] and complete successfully '
        'when the call to remote source is successfull', () async {
      // arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) => Future.value());

      // act
      final result = await repoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      // assert
      expect(result, equals(const Right(null)));

      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
    });

    test(
        'should return a [ServerFailure] when the call to the remote source'
        'is not successfull', () async {
      // Arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenThrow(tException);
      final result = await repoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      expect(
        result,
        equals(
          Left(
            APIFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          ),
        ),
      );

      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () {
    test(
      'should call the [RemoteDataSource.getUsers] and return [List<User>] '
      'when call to remote source is successfull',
      () async {
        when(() => remoteDataSource.getUsers()).thenAnswer(
          (_) async => [],
        );

        final result = await repoImpl.getUsers();

        expect(result, isA<Right<dynamic, List<User>>>());
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [APIFailure] when the call to the remote '
      'source is unsuccessfull.',
      () async {
        when(() => remoteDataSource.getUsers()).thenThrow(tException);

        final result = await repoImpl.getUsers();

        expect(result, equals(Left(APIFailure.fromException(tException))));
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
