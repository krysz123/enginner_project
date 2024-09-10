import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/features/personalization/controllers/user_controller.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/models/user_model.dart';
import 'package:enginner_project/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:enginner_project/utils/exceptions/firebase_exceptions.dart';
import 'package:enginner_project/utils/exceptions/format_exceptions.dart';
import 'package:enginner_project/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
      // await _db.collection("Users").doc(user.id).collection("Expense").doc(expense.id).set(expense.toJson)); cos takiego chyba
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Coś poszło nie tak. Spróbuj ponownie';
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Coś poszło nie tak. Spróbuj ponownie';
    }
  }

  Future<void> saveExpenseRecord(ExpenseModel model) async {
    try {
      // _db.settings = const Settings(persistenceEnabled: true);

      _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Transactions")
          .doc(model.id)
          .set(model.toJson());
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Coś poszło nie tak. Spróbuj ponownie';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Coś poszło nie tak. Spróbuj ponownie';
    }
  }

  Future<List<ExpenseModel>> fetchAllTransactions() async {
    try {
      // Pobranie dokumentów transakcji dla zalogowanego użytkownika
      final querySnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Transactions")
          .orderBy('Date', descending: true) // Sortowanie według daty
          .get();

      // Mapowanie wyników na listę modeli ExpenseModel
      return querySnapshot.docs
          .map((doc) => ExpenseModel.fromSnapshot(doc))
          .toList();
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Coś poszło nie tak. Spróbuj ponownie';
    }
  }

  Stream<double> streamTotalBalance() {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .snapshots()
        .map((snapshot) {
      // Sprawdzenie czy dokument istnieje i czy posiada pole TotalBalance
      final data = snapshot.data();
      if (data != null && data.containsKey('TotalBalance')) {
        return data['TotalBalance'].toDouble();
      } else {
        return 0.0; // Wartość domyślna, jeśli brak danych
      }
    });
  }

  Stream<List<ExpenseModel>> streamAllTransactions() {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("Transactions")
        .orderBy('Date', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => ExpenseModel.fromSnapshot(doc))
            .toList());
  }

  Future<void> deleteExpense(
      String expenseType, String transactionId, double amount) async {
    try {
      _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Transactions")
          .doc(transactionId)
          .delete();

      final userController = UserController.instance;
      double balance = 0;

      if (expenseType == 'income') {
        balance = userController.totalBalance.value - amount;
      } else {
        balance = userController.totalBalance.value + amount;
      }

      Map<String, dynamic> deletedValue = {'TotalBalance': balance};
      await updateSingleField(deletedValue);
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Coś poszło nie tak. Spróbuj ponownie';
    }
  }
}
