import 'package:flutter/material.dart';

class UserModel {
  final String id;
  String firstname;
  String lastname;
  final String email;
  String phoneNumber;

  UserModel({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phoneNumber,
  });

  String get fullname => '$firstname $lastname';

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstname,
      'LastName': lastname,
      'Email': email,
      'PhoneNumber': phoneNumber,
    };
  }
}
