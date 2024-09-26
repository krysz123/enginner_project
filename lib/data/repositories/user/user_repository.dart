import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/features/personalization/controllers/user_controller.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/models/loyalty_card_model.dart';
import 'package:enginner_project/models/saving_goal_model.dart';
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
      final querySnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Transactions")
          .orderBy('Date', descending: true)
          .get();

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
      final data = snapshot.data();
      if (data != null && data.containsKey('TotalBalance')) {
        return data['TotalBalance'].toDouble();
      } else {
        return 0.0;
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

      if (expenseType == 'Przychód') {
        balance = userController.totalBalance.value - amount;
      } else {
        balance = userController.totalBalance.value + amount;
      }

      userController.cancelMonthlyTask(transactionId);

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

  Future<void> saveLoyaltyCard(LoyaltyCardModel model) async {
    try {
      _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("LoyaltyCards")
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

  Stream<List<LoyaltyCardModel>> streamAllLoyaltyCards() {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("LoyaltyCards")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => LoyaltyCardModel.fromSnapshot(doc))
            .toList());
  }

  Future<void> deleteLoyaltyCard(String loyaltyCardId) async {
    try {
      _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("LoyaltyCards")
          .doc(loyaltyCardId)
          .delete();
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

  Future<void> saveSavingGoal(SavingGoalModel model) async {
    try {
      _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("SavingGoals")
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

  Stream<List<SavingGoalModel>> streamAllSavingGoals() {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("SavingGoals")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => SavingGoalModel.fromSnapshot(doc))
            .toList());
  }

  // Stream<double> streamSavingGoalProgress() {
  //   return _db
  //       .collection("Users")
  //       .doc(AuthenticationRepository.instance.authUser?.uid)
  //       .collection("SavingGoals")
  //       .doc()
  //       .snapshots()
  //       .map((snapshot) {
  //     final data = snapshot.data();
  //     if (data != null && data.containsKey('CurrentAmount')) {
  //       return data['CurrentAmount'];
  //     } else {
  //       return 0.0;
  //     }
  //   });
  // }

  Future<void> addAmount(String documentId, double amount) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("SavingGoals")
          .doc(documentId)
          .update(
        {
          'CurrentAmount': FieldValue.increment(amount),
        },
      );
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

  Future<void> updateEndedSavingGoal(
      Map<String, dynamic> json, String documentId) async {
    try {
      _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection('SavingGoals')
          .doc(documentId)
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
}
