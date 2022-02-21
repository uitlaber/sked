import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  RxString operatorName = ''.obs;
  late final SharedPreferences box;

  final operatorNameTextController = TextEditingController();

  @override
  Future<void> onInit() async {
    box = await SharedPreferences.getInstance();

    super.onInit();
    operatorName.value = box.getString('operatorName')!;
  }

  void setOperatorName(String name) {
    operatorName.value = name;
    box.setString('operatorName', name);
  }

  Future showOperatorSettingsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                    ),
                    hintText: 'Имя оператора',
                  ),
                  controller: operatorNameTextController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      setOperatorName(operatorNameTextController.value.text);
                      Get.back();
                    },
                    child: const Text('СОХРАНИТЬ'))
              ],
            ),
          ),
        );
      },
    );
  }
}
