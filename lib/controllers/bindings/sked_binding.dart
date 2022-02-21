import 'package:get/get.dart';
import 'package:sked/controllers/sked_controller.dart';

class SkedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SkedController());
  }
}