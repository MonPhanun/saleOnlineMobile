import 'package:get/get.dart';
import 'package:saleonlinemobile/controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}
