import 'dart:convert';

import 'package:bloc_tdd_sample/core/utils/typedef.dart';
import 'package:bloc_tdd_sample/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.avatar,
    required super.createdAt,
    required super.name,
  });

  const UserModel.empty()
      : this(
          id: '1',
          avatar: '_empty.avatar',
          createdAt: '_empty.createdAt',
          name: '_empty.name',
        );

  // Data that comes from the server
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          avatar: map['avatar'] as String,
          createdAt: map['createdAt'] as String,
          name: map['name'] as String,
        );

  // Sending data to the server
  DataMap toMap() => {
        'id': id,
        'avatar': avatar,
        'createdAt': createdAt,
        'name': name,
      };

  String toJson() => jsonEncode(toMap());

  // Update User with copyWith()
  UserModel copyWith({
    String? id,
    String? avatar,
    String? createdAt,
    String? name,
  }) {
    // updated with new values if they are not null otherwise use one from "this".
    return UserModel(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
    );
  }
}
