import 'package:enginner_project/features/app/controllers/navigation_controller.dart';
import 'package:enginner_project/utils/device/network_connection.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkConnection());
    // Get.put(SideBarController());
  }
}
