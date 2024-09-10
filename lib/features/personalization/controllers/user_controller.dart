import 'package:enginner_project/data/repositories/user/user_repository.dart';
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
    userRepository.streamTotalBalance().listen((event) {
      totalBalance.value = event;
    });
  }

  Future<void> fetchUserRecord() async {
    try {
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }
  }
}
