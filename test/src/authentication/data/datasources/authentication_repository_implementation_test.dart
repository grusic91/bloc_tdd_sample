import 'dart:convert';

import 'package:bloc_tdd_sample/core/errors/exceptions.dart';
import 'package:bloc_tdd_sample/core/utils/constants.dart';
import 'package:bloc_tdd_sample/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when the status code is 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201));

      final methodCall = remoteDataSource.createUser;

      expect(
        methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        completes,
      );

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
          body: jsonEncode(
            {
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            },
          ),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test(
        'should throw an [APIException] when the status code is not 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Invalid email address', 400));

      final methodCall = remoteDataSource.createUser;

      expect(
          () async => await methodCall(
                createdAt: 'createdAt',
                name: 'name',
                avatar: 'avatar',
              ),
          throwsA(const APIException(
              message: 'Invalid email address', statusCode: 400)));

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
          body: jsonEncode(
              {'createdAt': 'createdAt', 'name': 'name', 'avatar': 'avatar'}),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
