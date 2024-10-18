import 'package:cron/cron.dart';
import 'package:enginner_project/data/repositories/user/user_repository.dart';
import 'package:enginner_project/enums/expense_type.dart';
import 'package:enginner_project/models/expense_model.dart';
import 'package:enginner_project/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  Rx<double> totalBalance = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
    userRepository.streamTotalBalance().listen(
      (event) {
        totalBalance.value = event;
      },
    );
  }

  // final cron = Cron();
  // final Map<String, ScheduledTask> _tasks = {};
  // void addExpenseMonthlyTask(String transactionId, ExpenseModel newExpense) {
  //   final task = cron.schedule(Schedule.parse('*/30 * * * * *'), () async {
  //     var uuid = const Uuid();
  //     String regularExpenseId = uuid.v4();
  //     final scheduledExpense = ExpenseModel(
  //         id: regularExpenseId,
  //         amount: newExpense.amount,
  //         category: newExpense.category,
  //         date: newExpense.date,
  //         description: newExpense.description,
  //         expenseType: newExpense.expenseType,
  //         title: 'Wydatek stały: ${newExpense.title}',
  //         paymentType: ExpenseTypeEnum.periodicExpense.label);

  //     await userRepository.saveExpenseRecord(scheduledExpense);

  //     user.update((user) {
  //       user!.totalBalance -= newExpense.amount;
  //     });

  //     Map<String, dynamic> updatedExpense = {
  //       'TotalBalance': totalBalance.value - newExpense.amount
  //     };
  //     await userRepository.updateSingleField(updatedExpense);
  //   });

  //   _tasks[transactionId] = task;
  // }

  // void addIncomeMonthlyTask(String transactionId, ExpenseModel newExpense) {
  //   final task = cron.schedule(Schedule.parse('0 0 1 * *'), () async {
  //     var uuid = const Uuid();
  //     String regularIncomeId = uuid.v4();
  //     final scheduledIncome = ExpenseModel(
  //         id: regularIncomeId,
  //         amount: newExpense.amount,
  //         category: newExpense.category,
  //         date: newExpense.date,
  //         description: newExpense.description,
  //         expenseType: newExpense.expenseType,
  //         title: 'Przychód stały: ${newExpense.title}',
  //         paymentType: ExpenseTypeEnum.periodicIncome.label);
  //     await userRepository.saveExpenseRecord(scheduledIncome);

  //     user.update((user) {
  //       user!.totalBalance += newExpense.amount;
  //     });

  //     Map<String, dynamic> updatedExpense = {
  //       'TotalBalance': totalBalance.value + newExpense.amount
  //     };
  //     await userRepository.updateSingleField(updatedExpense);
  //   });

  //   _tasks[transactionId] = task;
  // }

  // void cancelMonthlyTask(String transactionId) {
  //   final task = _tasks.remove(transactionId);
  //   task?.cancel();
  // }

  Future<void> fetchUserRecord() async {
    try {
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }
  }
}
