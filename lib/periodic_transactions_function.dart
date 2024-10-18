import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/firebase_options.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';

@pragma("vm:entry-point")
void callbackDispatcher() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    try {
      var uuid = const Uuid();
      String periodicTaskId = uuid.v4();

      String title = inputData?['Title'];
      double amount = inputData?['Amount'];
      String category = inputData?['Category'];
      String description = inputData?['Description'];
      String expenseType = inputData?['Type'];
      String paymentType = inputData?['PaymentType'];
      String date = DateTime.now().toString().split(" ")[0];
      User? user = FirebaseAuth.instance.currentUser;

      if (expenseType == ExpenseTypeEnum.periodicIncome.label) {
        final periodicIncome = ExpenseModel(
          id: periodicTaskId,
          amount: amount,
          category: category,
          date: date,
          description: description,
          expenseType: ExpenseTypeEnum.income.label,
          title: 'Przychód stały: $title',
          paymentType: paymentType,
        );

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user?.uid)
            .collection("Transactions")
            .doc(periodicTaskId)
            .set(periodicIncome.toJson());

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user?.uid)
            .update(
          {
            'TotalBalance': FieldValue.increment(amount),
          },
        );
      } else if (expenseType == ExpenseTypeEnum.periodicExpense.label) {
        final periodicExpense = ExpenseModel(
          id: periodicTaskId,
          amount: amount,
          category: category,
          date: date,
          description: description,
          expenseType: ExpenseTypeEnum.expense.label,
          title: 'Wydatek stały: $title',
          paymentType: paymentType,
        );

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user?.uid)
            .collection("Transactions")
            .doc(periodicTaskId)
            .set(periodicExpense.toJson());

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user?.uid)
            .update(
          {
            'TotalBalance': FieldValue.increment(-amount),
          },
        );
      }

      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  });
}
