class ExpenseModel {
  final String id;
  String title;
  double amount;
  String description;
  String date;
  String category;
  String expenseType;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
    required this.expenseType,
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Amount': amount,
      'Description': description,
      'Date': date,
      'Category': category,
      'Type': expenseType,
    };
  }
}
