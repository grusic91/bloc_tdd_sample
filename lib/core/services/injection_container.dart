import 'package:http/http.dart' as http;
import 'package:bloc_tdd_sample/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:bloc_tdd_sample/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/repositories/authentiaction_repository.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/usecases/create_user.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/usecases/get_users.dart';
import 'package:bloc_tdd_sample/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // App Logic
  sl
    ..registerFactory(() => AuthenticationCubit(
          createUser: sl(),
          getUsers: sl(),
        ))

    // Use Cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // Reposiotries
    ..registerLazySingleton<AuthoenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))

    // Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))

    // External dependecies
    ..registerLazySingleton(() => http.Client());
}
