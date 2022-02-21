import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sked/controllers/app_controller.dart';
import 'package:sked/routes.dart';
import 'package:sked/ui/ui.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text((controller.operatorName.isEmpty)
                ? 'Имя оператора'
                : controller.operatorName.value),
            actions: [
              IconButton(
                icon: const Icon(Icons.manage_accounts),
                tooltip: 'Настройки поля',
                onPressed: () {
                  controller.showOperatorSettingsDialog(context);
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.createSked),
                    style: myButtonGreenStyle,
                    child: const Text('Создать новую опись')),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.archiveSked),
                    style: myButtonBlueStyle,
                    child: const Text('Архив описей')),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.toNamed(Routes.settings),
            child: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ));
  }
}
