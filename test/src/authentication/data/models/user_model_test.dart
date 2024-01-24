import 'package:bloc_tdd_sample/src/authentication/data/models/user_model.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // group test
  // let as groupt test

  test('should be a subclass of [User] entity', () {
    // Arrange
    const tModel = UserModel.empty();
    // Act

    // Assert
    expect(tModel, isA<User>());
  });

  group('fromMap', () {});
}
