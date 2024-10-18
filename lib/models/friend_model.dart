import 'package:cloud_firestore/cloud_firestore.dart';

class FriendModel {
  final String id;
  final String email;
  final String fullname;
  final String status;

  FriendModel({
    required this.id,
    required this.email,
    required this.fullname,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'Email': email,
      'Fullname': fullname,
      'Status': status,
    };
  }

  static FriendModel empty() => FriendModel(
        id: '',
        email: '',
        fullname: '',
        status: '',
      );

  factory FriendModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return FriendModel(
        id: document.id,
        email: data['Email'] ?? '',
        fullname: data['Fullname'] ?? '',
        status: data['Status'] ?? '',
      );
    } else {
      return FriendModel.empty();
    }
  }
}
