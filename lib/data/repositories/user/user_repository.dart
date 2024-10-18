import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/enums/debts_types_enum.dart';
import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/enums/friend_status_enum.dart';
import 'package:enginner_project/features/personalization/controllers/user_controller.dart';
import 'package:enginner_project/models/debt_model.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/models/friend_model.dart';
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
import 'package:workmanager/workmanager.dart';

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
    print('---------------- uruchamia sie stream --------------  ');
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

      if (expenseType == ExpenseTypeEnum.income.label ||
          expenseType == ExpenseTypeEnum.periodicIncome.label) {
        balance = userController.totalBalance.value - amount;
      } else {
        balance = userController.totalBalance.value + amount;
      }

      Workmanager().cancelByUniqueName(transactionId);

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

  Future<void> incrementCurrentBalance(double amount) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(
        {
          'TotalBalance': FieldValue.increment(amount),
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

  Future<void> decrementCurrentBalance(double amount) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(
        {
          'TotalBalance': FieldValue.increment(-amount),
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

  Stream<List<ExpenseModel>> streamOnlyExpenses() {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("Transactions")
        .where("Type", isEqualTo: ExpenseTypeEnum.expense.label)
        .orderBy('Date', descending: false)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => ExpenseModel.fromSnapshot(doc))
            .toList());
  }

  Stream<List<ExpenseModel>> streamOnlyIncomes() {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("Transactions")
        .where("Type", isEqualTo: ExpenseTypeEnum.income.label)
        .orderBy('Date', descending: false)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => ExpenseModel.fromSnapshot(doc))
            .toList());
  }

  Future<bool> checkIfEmailExist(String email) async {
    try {
      final querySnapshot = await _db
          .collection("Users")
          .where("Email", isEqualTo: email)
          .limit(1)
          .get();
      return querySnapshot.docs.isNotEmpty;
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

  Future<bool> checkIfinviteWasSended(
      String senderId, String recipientId) async {
    try {
      final senderQuery = await _db
          .collection("Users")
          .doc(senderId)
          .collection("Friends")
          .doc(recipientId)
          .get();
      final recipientQuery = await _db
          .collection("Users")
          .doc(recipientId)
          .collection("Friends")
          .doc(senderId)
          .get();

      if (!senderQuery.exists && !recipientQuery.exists) {
        return true;
      } else {
        return false;
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

  Future<void> sendInvite(String email) async {
    try {
      final controller = UserController.instance;

      final querySnapshot = await _db
          .collection("Users")
          .where("Email", isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> data = querySnapshot.docs.first;
        final userToInvite = UserModel.fromSnapshot(data);

        final invitationCheck = await checkIfinviteWasSended(
            AuthenticationRepository.instance.authUser!.uid, userToInvite.id);

        if (!invitationCheck) {
          throw 'Zaproszenie zostało już wysłane';
        }

        // Do otrzymującego zaproszenie
        await _db
            .collection("Users")
            .doc(userToInvite.id)
            .collection("Friends")
            .doc(AuthenticationRepository.instance.authUser?.uid)
            .set(<String, dynamic>{
          'Fullname': controller.user.value.fullname,
          'Email': controller.user.value.email,
          'Status': FriendStatusEnum.invitation.label
        });

        // Do wysyłającego zaproszenie
        await _db
            .collection("Users")
            .doc(AuthenticationRepository.instance.authUser?.uid)
            .collection("Friends")
            .doc(userToInvite.id)
            .set(<String, dynamic>{
          'Fullname': userToInvite.fullname,
          'Email': userToInvite.email,
          'Status': FriendStatusEnum.sendInvite.label,
        });
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
      throw '$e';
    }
  }

  Future<void> acceptInvite(String friendId) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Friends")
          .doc(friendId)
          .update(<String, dynamic>{"Status": FriendStatusEnum.accepted.label});

      await _db
          .collection("Users")
          .doc(friendId)
          .collection("Friends")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(<String, dynamic>{"Status": FriendStatusEnum.accepted.label});
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      print('Error $e');
      throw '$e';
    }
  }

  Stream<List<FriendModel>> streamInvitations() {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("Friends")
        .where("Status", whereIn: [
          FriendStatusEnum.invitation.label,
          FriendStatusEnum.sendInvite.label,
          FriendStatusEnum.rejected.label,
        ])
        .orderBy('Status', descending: false)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => FriendModel.fromSnapshot(doc))
            .toList());
  }

  Stream<List<FriendModel>> streamFriendsList() {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("Friends")
        .where("Status", isEqualTo: FriendStatusEnum.accepted.label)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => FriendModel.fromSnapshot(doc))
            .toList());
  }

  Future<void> saveNewDebt(String friendId, DebtModel model) async {
    try {
      // Otrzymujący dług
      await _db
          .collection("Users")
          .doc(friendId)
          .collection("Friends")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Debts")
          .doc()
          .set(<String, dynamic>{
        'Title': model.title,
        'Description': model.description,
        'Amount': model.amount,
        'Type': DebtsTypesEnum.debts.label,
        'Status': false,
        'Timestamp': model.timestamp,
      });

      // Do tworzącego dług
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Friends")
          .doc(friendId)
          .collection("Debts")
          .doc()
          .set(<String, dynamic>{
        'Title': model.title,
        'Description': model.description,
        'Amount': model.amount,
        'Type': DebtsTypesEnum.claims.label,
        'Status': false,
        'Timestamp': model.timestamp,
      });
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw '$e';
    }
  }
}
