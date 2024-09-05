import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstname;
  String lastname;
  final String email;
  String phoneNumber;
  double totalBalance;

  UserModel({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phoneNumber,
    required this.totalBalance,
  });

  String get fullname => '$firstname $lastname';

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstname,
      'LastName': lastname,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'TotalBalance': totalBalance,
    };
  }

  static UserModel empty() => UserModel(
        id: '',
        email: '',
        firstname: '',
        lastname: '',
        phoneNumber: '',
        totalBalance: 0.0,
      );

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstname: data['FirstName'] ?? '',
        lastname: data['LastName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        totalBalance: data['TotalBalance'] ?? 0.0,
      );
    } else {
      return UserModel.empty();
    }
  }
}
