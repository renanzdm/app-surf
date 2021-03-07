import 'dart:convert';

import 'package:surf_app/modules/auth/login/domain/entities/user.dart';

class UserModel extends User {
  final String id;
  final String name;
  final String email;
  final String token;

  UserModel({this.id, this.name, this.email, this.token});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
