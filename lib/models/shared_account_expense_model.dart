import 'package:cloud_firestore/cloud_firestore.dart';

class SharedAccountExpenseModel {
  final String id;
  String title;
  double amount;
  String description;
  String date;
  String category;
  String expenseType;
  String paymentType;
  String sender;

  SharedAccountExpenseModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
    required this.expenseType,
    required this.title,
    required this.paymentType,
    required this.sender,
  });

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Amount': amount,
      'Description': description,
      'Date': date,
      'Category': category,
      'Type': expenseType,
      'PaymentType': paymentType,
      'Sender': sender
    };
  }

  static SharedAccountExpenseModel empty() => SharedAccountExpenseModel(
        id: '',
        title: '',
        amount: 0,
        category: '',
        date: '',
        description: '',
        expenseType: '',
        paymentType: '',
        sender: '',
      );

  factory SharedAccountExpenseModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return SharedAccountExpenseModel(
        id: document.id,
        title: data['Title'] ?? '',
        amount: data['Amount'] ?? '',
        description: data['Description'] ?? '',
        date: data['Date'] ?? '',
        category: data['Category'] ?? '',
        expenseType: data['Type'] ?? '',
        paymentType: data['PaymentType'] ?? '',
        sender: data['Sender'] ?? '',
      );
    } else {
      return SharedAccountExpenseModel.empty();
    }
  }
}
