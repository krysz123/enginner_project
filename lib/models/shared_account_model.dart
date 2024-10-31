// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class SharedAccountModel {
  String id;
  String title;
  double currentBalance;
  String owner;
  Map<String, dynamic> members;

  SharedAccountModel({
    required this.id,
    required this.title,
    required this.currentBalance,
    required this.owner,
    required this.members,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Title': title,
      'CurrentBalance': currentBalance,
      'Owner': owner,
      'Members': members,
    };
  }

  static SharedAccountModel empty() => SharedAccountModel(
      id: '', title: '', currentBalance: 0, owner: '', members: {});

  factory SharedAccountModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return SharedAccountModel(
        id: document.id,
        title: data['Title'],
        currentBalance: (data['CurrentBalance'] as num).toDouble(),
        members: data['Members'],
        owner: data['Owner'],
      );
    } else {
      return SharedAccountModel.empty();
    }
  }
}
