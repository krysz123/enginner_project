import 'package:enginner_project/utils/device/network_connection.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkConnection());
  }
}
