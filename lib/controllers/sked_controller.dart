import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sked/models/model.dart';


class SkedController extends GetxController {
  var sked = Sked().obs;
  @override
  void onInit() async {
    super.onInit();
    final id = int.tryParse(Get.parameters['id']??'');
    if(id != null){
      sked.value = await Sked().getById(id)??Sked();
    }
  }

  void onTapAction(int index) {
    if (kDebugMode) {
      print(index);
    }
  }
}
