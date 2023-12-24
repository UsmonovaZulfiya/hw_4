import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  // Convenience method to convert a Map to a User instance
  factory User.fromMap(Map<String, dynamic> map) {

    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"id": id, "name": name, "email": email};
    return map;
  }
}