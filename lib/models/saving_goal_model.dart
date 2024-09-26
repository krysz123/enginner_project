import 'package:cloud_firestore/cloud_firestore.dart';

class SavingGoalModel {
  final String id;
  String title;
  double currentAmount;
  double goal;
  bool status;
  String description;

  SavingGoalModel({
    required this.id,
    required this.title,
    required this.currentAmount,
    required this.goal,
    required this.status,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'CurrentAmount': currentAmount,
      'Goal': goal,
      'Status': status,
      'Description': description,
    };
  }

  factory SavingGoalModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return SavingGoalModel(
        id: document.id,
        title: data['Title'] as String,
        currentAmount: data['CurrentAmount'] as double,
        goal: data['Goal'] as double,
        status: data['Status'] as bool,
        description: data['Description'] as String,
      );
    } else {
      return SavingGoalModel.empty();
    }
  }

  static SavingGoalModel empty() => SavingGoalModel(
      id: '',
      title: '',
      currentAmount: 0,
      goal: 0,
      status: false,
      description: '');
}
