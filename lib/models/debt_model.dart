import 'package:cloud_firestore/cloud_firestore.dart';

class DebtModel {
  String title;
  double amount;
  String type;
  bool status;
  String description;

  Timestamp timestamp;

  DebtModel({
    required this.description,
    required this.title,
    required this.amount,
    required this.type,
    required this.status,
    required this.timestamp,
  });

  static DebtModel empty() => DebtModel(
        title: '',
        description: '',
        amount: 0,
        status: false,
        type: '',
        timestamp: Timestamp.now(),
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Title': title,
      'Description': description,
      'Amount': amount,
      'Type': type,
      'Status': status,
      'Timestamp': timestamp,
    };
  }

  factory DebtModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return DebtModel(
        amount: data['Amount'],
        description: data['Description'],
        type: data['Type'],
        title: data['Title'],
        timestamp: Timestamp.now(),
        status: data['Status'] ?? '',
      );
    } else {
      return DebtModel.empty();
    }
  }
}
