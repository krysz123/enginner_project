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
import 'package:enginner_project/models/shared_account_expense_model.dart';
import 'package:enginner_project/models/shared_account_model.dart';
import 'package:enginner_project/models/user_model.dart';
import 'package:enginner_project/utils/exceptions/handle_exceptions.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } catch (e) {
      throw handleExceptions(e);
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
    } catch (e) {
      throw handleExceptions(e);
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
    } catch (e) {
      throw handleExceptions(e);
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

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } catch (e) {
      throw handleExceptions(e);
    }
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

      QuerySnapshot allSavingGoals = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("SavingGoals")
          .get();

      for (var doc in allSavingGoals.docs) {
        DocumentSnapshot paymentSnapshot =
            await doc.reference.collection("Payments").doc(transactionId).get();

        if (paymentSnapshot.exists) {
          await paymentSnapshot.reference.delete();
          await deleteAmount(doc.id, amount);
        }
      }

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
    } catch (e) {
      throw handleExceptions(e);
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
    } catch (e) {
      throw handleExceptions(e);
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
    } catch (e) {
      throw handleExceptions(e);
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
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Future<void> addSavingGoalPayment(SavingGoalModel model, double amount,
      String date, String paymentId) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("SavingGoals")
          .doc(model.id)
          .collection("Payments")
          .doc(paymentId)
          .set({
        "Amount": amount,
        "Date": date,
      });
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Future<void> addSavingGoalPaymentToTransactions(
      SavingGoalModel model,
      double amount,
      String date,
      String paymentId,
      ExpenseModel expenseModel) async {
    try {
      _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Transactions")
          .doc(paymentId)
          .set(expenseModel.toJson());
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Stream<List<Map<String, dynamic>>> streamGoalPayments(String goalId) {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("SavingGoals")
        .doc(goalId)
        .collection("Payments")
        .orderBy("Date", descending: false)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return {
          "Amount": doc["Amount"] as double,
          "Date": doc["Date"] as String,
        };
      }).toList();
    });
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
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Future<void> deleteAmount(String documentId, double amount) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("SavingGoals")
          .doc(documentId)
          .update(
        {
          'CurrentAmount': FieldValue.increment(-amount),
        },
      );
    } catch (e) {
      throw handleExceptions(e);
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
    } catch (e) {
      throw handleExceptions(e);
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
    } catch (e) {
      throw handleExceptions(e);
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
    } catch (e) {
      throw handleExceptions(e);
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
    } catch (e) {
      throw handleExceptions(e);
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
    } catch (e) {
      throw handleExceptions(e);
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
    } catch (e) {
      throw '$e';
    }
  }

  Future<void> deleteFriend(String friendId) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Friends")
          .doc(friendId)
          .delete();

      await _db
          .collection("Users")
          .doc(friendId)
          .collection("Friends")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .delete();
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
    } catch (e) {
      throw '$e';
    }
  }

  Future<void> rejectInvite(String friendId) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Friends")
          .doc(friendId)
          .update(<String, dynamic>{"Status": FriendStatusEnum.rejected.label});
    } catch (e) {
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

  Stream<int> streamFriendsInvitationsCount() {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("Friends")
        .where("Status", isEqualTo: FriendStatusEnum.invitation.label)
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);
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
          .doc(model.id)
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
          .doc(model.id)
          .set(<String, dynamic>{
        'Title': model.title,
        'Description': model.description,
        'Amount': model.amount,
        'Type': DebtsTypesEnum.claims.label,
        'Status': false,
        'Timestamp': model.timestamp,
      });
    } catch (e) {
      throw '$e';
    }
  }

  Stream<List<DebtModel>> streamAllDebts(String friendId) {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("Friends")
        .doc(friendId)
        .collection("Debts")
        .orderBy("Status", descending: false)
        .orderBy("Timestamp", descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => DebtModel.fromSnapshot(doc))
            .toList());
  }

  Future<void> setDebtAsReturned(String friendId, String debtId) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Friends")
          .doc(friendId)
          .collection("Debts")
          .doc(debtId)
          .update({
        "Status": true,
      });

      await _db
          .collection("Users")
          .doc(friendId)
          .collection("Friends")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Debts")
          .doc(debtId)
          .update({
        "Status": true,
      });
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Future<void> storeNewSharedAccount(SharedAccountModel model) async {
    try {
      await _db.collection("SharedAccounts").doc(model.id).set(model.toJson());
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Future<void> inviteToSharedAccount(String sharedAccountId, memberId) async {
    try {
      await _db
          .collection("SharedAccounts")
          .doc(sharedAccountId)
          .update({'Members.$memberId': false});
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Stream<int> streamNewDebtsCount(String friendId) {
    return _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .collection("Friends")
        .doc(friendId)
        .collection("Debts")
        .where('Status', isEqualTo: false)
        .where('Type', isEqualTo: DebtsTypesEnum.debts.label)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.length);
  }

  Stream<int> streamSharedAccountInvitationsCount() {
    return _db
        .collection("SharedAccounts")
        .where(
          'Members.${AuthenticationRepository.instance.authUser?.uid}',
          isEqualTo: false,
        )
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.length);
  }

  Stream<List<SharedAccountModel>> streamSharedAccountInvitations() {
    return _db
        .collection("SharedAccounts")
        .where('Members.${AuthenticationRepository.instance.authUser?.uid}',
            isEqualTo: false)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => SharedAccountModel.fromSnapshot(doc))
            .toList());
  }

  Future<void> acceptInviteToSharedAccount(
      String id, String sharedAccountId) async {
    try {
      await _db
          .collection("SharedAccounts")
          .doc(sharedAccountId)
          .update({'Members.$id': true});
    } catch (e) {
      throw '$e';
    }
  }

  Future<void> rejectInviteToSharedAccount(
      String id, String sharedAccountId) async {
    try {
      await _db
          .collection("SharedAccounts")
          .doc(sharedAccountId)
          .update({'Members.$id': FieldValue.delete()});
    } catch (e) {
      throw '$e';
    }
  }

  Stream<List<SharedAccountModel>> streamSharedAccounts() {
    return _db
        .collection("SharedAccounts")
        .where('Members.${AuthenticationRepository.instance.authUser?.uid}',
            isEqualTo: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => SharedAccountModel.fromSnapshot(doc))
            .toList());
  }

  Future<void> saveSharedAccountExpense(
      SharedAccountExpenseModel model, String sharedAccountId) async {
    try {
      _db
          .collection("SharedAccounts")
          .doc(sharedAccountId)
          .collection("Transactions")
          .doc(model.id)
          .set(model.toJson());
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Future<List<SharedAccountExpenseModel>> fetchAllSharedAccountTransactions(
      String sharedAccountId) async {
    try {
      final querySnapshot = await _db
          .collection("SharedAccounts")
          .doc(sharedAccountId)
          .collection("Transactions")
          .orderBy('Date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => SharedAccountExpenseModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Stream<double> streamSharedAccountTotalBalance(String sharedAccountId) {
    return _db
        .collection("SharedAccounts")
        .doc(sharedAccountId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (data != null && data.containsKey('CurrentBalance')) {
        return data['CurrentBalance'].toDouble();
      } else {
        return 0.0;
      }
    });
  }

  Stream<List<SharedAccountExpenseModel>> streamAllSharedAccountTransactions(
      String sharedAccountId) {
    return _db
        .collection("SharedAccounts")
        .doc(sharedAccountId)
        .collection("Transactions")
        .orderBy('Date', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => SharedAccountExpenseModel.fromSnapshot(doc))
            .toList());
  }

  Future<void> deleteSharedAccountExpense(String transactionId,
      String sharedAccountId, String type, double amount) async {
    try {
      _db
          .collection("SharedAccounts")
          .doc(sharedAccountId)
          .collection("Transactions")
          .doc(transactionId)
          .delete();

      if (type == ExpenseTypeEnum.expense.label) {
        incrementSharedAccountCurrentBalance(amount, sharedAccountId);
      } else {
        decrementSharedAccountCurrentBalance(amount, sharedAccountId);
      }
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Future<void> incrementSharedAccountCurrentBalance(
      double amount, String sharedAccountId) async {
    try {
      await _db.collection("SharedAccounts").doc(sharedAccountId).update(
        {
          'CurrentBalance': FieldValue.increment(amount),
        },
      );
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Future<void> decrementSharedAccountCurrentBalance(
      double amount, String sharedAccountId) async {
    try {
      await _db.collection("SharedAccounts").doc(sharedAccountId).update(
        {
          'CurrentBalance': FieldValue.increment(-amount),
        },
      );
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  Stream<List<Map<String, String>>> streamUsersToSharedAccount(
      String sharedAccountId, bool isMember) async* {
    try {
      await for (DocumentSnapshot<Map<String, dynamic>> sharedAccountSnapshot
          in _db
              .collection("SharedAccounts")
              .doc(sharedAccountId)
              .snapshots()) {
        if (sharedAccountSnapshot.exists) {
          Map<String, dynamic> members = sharedAccountSnapshot.get('Members');

          List<String> userIds = members.entries
              .where((entry) => entry.value == isMember)
              .map((entry) => entry.key)
              .toList();

          List<Map<String, String>> friends = [];

          for (String userId in userIds) {
            DocumentSnapshot<Map<String, dynamic>> userSnapshot =
                await _db.collection('Users').doc(userId).get();

            if (userSnapshot.exists) {
              final data = userSnapshot.data();

              if (data != null) {
                friends.add({
                  'id': userId,
                  'FirstName': '${data['FirstName']}',
                  'LastName': '${data['LastName']}',
                  'Email': '${data['Email']}',
                });
              }
            } else {
              throw 'Nie odnaleziono';
            }
          }

          yield friends;
        } else {
          throw 'Dokument nie istnieje';
        }
      }
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Stream<List<Map<String, String>>> streamUsersNotInSharedAccount(
      String sharedAccountId) async* {
    try {
      await for (DocumentSnapshot<Map<String, dynamic>> sharedAccountSnapshot
          in _db
              .collection("SharedAccounts")
              .doc(sharedAccountId)
              .snapshots()) {
        if (sharedAccountSnapshot.exists) {
          Map<String, dynamic> members =
              sharedAccountSnapshot.get('Members') ?? {};

          List<Map<String, String>> nonMembers = [];

          QuerySnapshot<Map<String, dynamic>> usersSnapshot = await _db
              .collection('Users')
              .doc(AuthenticationRepository.instance.authUser?.uid)
              .collection('Friends')
              .where('Status', isEqualTo: 'Zaakceptowane')
              .get();

          for (var doc in usersSnapshot.docs) {
            String userId = doc.id;

            if (!members.containsKey(userId) || members[userId] == false) {
              final data = doc.data();

              nonMembers.add({
                'id': userId,
                'Fullname': '${data['Fullname']}',
              });
            }
          }

          yield nonMembers;
        } else {
          throw 'Błąd! Dokument nie istnieje.';
        }
      }
    } catch (e) {
      throw 'Coś poszło nie tak. Spróbuj ponownie.';
    }
  }

  Future<List<Map<String, String>>> fetchUsersToSharedAccount(
      String sharedAccountId, bool isMember) async {
    List<Map<String, String>> users = [];
    try {
      DocumentSnapshot sharedAccountSnapshot =
          await _db.collection("SharedAccounts").doc(sharedAccountId).get();

      if (sharedAccountSnapshot.exists) {
        Map<String, dynamic> members = sharedAccountSnapshot.get('Members');

        List<String> usersIds = members.entries
            .where((entry) => entry.value == isMember)
            .map((entry) => entry.key)
            .toList();

        for (String userId in usersIds) {
          DocumentSnapshot userSnapshot =
              await _db.collection('Users').doc(userId).get();

          if (userSnapshot.exists) {
            String firstName = userSnapshot.get('FirstName');
            String lastName = userSnapshot.get('LastName');

            users.add({
              'sharedAccountId': sharedAccountId,
              'id': userId,
              'firstName': firstName,
              'lastName': lastName,
            });
          } else {
            throw 'Błąd!';
          }
        }
      } else {
        throw 'Błąd! dokument nie istnieje.';
      }
    } catch (e) {
      throw handleExceptions(e);
    }
    return users;
  }

  Future<void> deleteSharedAccount(
    String sharedAccountId,
  ) async {
    try {
      _db.collection("SharedAccounts").doc(sharedAccountId).delete();
    } catch (e) {
      throw handleExceptions(e);
    }
  }
}
