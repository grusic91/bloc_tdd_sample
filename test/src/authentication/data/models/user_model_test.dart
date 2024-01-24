import 'dart:convert';

import 'package:bloc_tdd_sample/core/utils/typedef.dart';
import 'package:bloc_tdd_sample/src/authentication/data/models/user_model.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  // group test
  // let as groupt test
  const tModel = UserModel.empty();
  test('should be a subclass of [User] entity', () {
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with correct data', () {
      // Act
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });
  group('fromJson', () {
    test('should return a [UserModel] with correct data', () {
      // Act
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('shoud return a [Map] with correct data', () {
      // Act
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [JSON] data', () {
      // Act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
      });
      expect(result, equals(tJson));
    });
  });
  group('copyWith', () {
    test('should return a [UserModel] with updated data', () {
      // Act
      final result = tModel.copyWith(name: 'Paul');

      expect(result.name, equals('Paul'));
    });
  });
}
