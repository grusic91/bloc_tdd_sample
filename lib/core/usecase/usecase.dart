import 'package:bloc_tdd_sample/core/utils/typedef.dart';

abstract class UsecaseWithParams<T, Params> {
  const UsecaseWithParams();

  ResultFuture<T> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  ResultFuture<Type> call();
}
