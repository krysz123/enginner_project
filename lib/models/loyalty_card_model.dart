import 'package:cloud_firestore/cloud_firestore.dart';

class LoyaltyCardModel {
  final String id;
  String title;
  String code;

  LoyaltyCardModel({
    required this.id,
    required this.title,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Code': code,
    };
  }

  static LoyaltyCardModel empty() => LoyaltyCardModel(
        id: '',
        title: '',
        code: '',
      );

  factory LoyaltyCardModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return LoyaltyCardModel(
          id: document.id,
          title: data['Title'] ?? '',
          code: data['Code'] ?? '');
    } else {
      return LoyaltyCardModel.empty();
    }
  }
}
