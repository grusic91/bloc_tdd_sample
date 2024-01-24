// What does the class depend on?
// --- answer --- AuthoenticationRepository

// How can we create a fake version of the dependency
// -- use Mocktail

// How do we control what out dependecies do
// --- using the mocktail api

import 'package:bloc_tdd_sample/src/authentication/domain/entities/user.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/repositories/authentiaction_repository.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthoenticationRepository repository;
  late GetUsers usecase;

  // Setup is run before each test
  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty()];

  test(
    'should call the [AuthRepo.getUsers] and shuld return [List<User>]',
    () async {
      // Arrange
      // STUB
      when(
        () => repository.getUsers(),
      ).thenAnswer((_) async => const Right(tResponse));

      // Act

      final result = await usecase();
      expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
      verify(() => repository.getUsers()).called(1);
      verifyNoMoreInteractions(repository);
      // Assert
    },
  );
}
