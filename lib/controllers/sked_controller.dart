import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sked/models/model.dart';

class SkedController extends GetxController {
  List selectedClient = [].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await Sked(
            client_name: 'Андрей',
            operator_name: 'Олег',
            work_type: 1,
            data_type: 1,
            is_sended: false)
        .save();
  }

  void onTapAction(int index) {
    if (kDebugMode) {
      print(index);
    }
  }
}
