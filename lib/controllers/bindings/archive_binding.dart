import 'package:get/get.dart';
import 'package:sked/controllers/archive_controller.dart';

class ArchiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ArchiveController());
  }
}
