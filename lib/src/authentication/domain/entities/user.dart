import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  final int id;
  final String createdAt;
  final String name;
  final String avatar;
/*
this is done by equatable
  @override
  bool operator ==(other) {
    return identical(this, other) ||
        other is User && other.runtimeType == runtimeType && other.id == id;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
   */
  @override
  List<Object?> get props => [id];
}
