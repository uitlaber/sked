import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sked/controllers/app_controller.dart';
import 'package:sked/controllers/sked_controller.dart';

class CreateSked extends StatelessWidget {
  CreateSked({Key? key}) : super(key: key);
  final appController = Get.find<AppController>();
  final skedController = Get.find<SkedController>();

  @override
  Widget build(BuildContext context) {
    String currentTime = DateFormat('kk:mm').format(DateTime.now());
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return Obx(() => WillPopScope(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Новая запись'),
              automaticallyImplyLeading: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(appController.operatorName.value,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                              left: BorderSide(color: Colors.grey),
                              right: BorderSide(color: Colors.grey)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            currentTime,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(currentDate,
                              style: const TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: const InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, bottom: 25.0, left: 20.0, right: 20.0),
                      child: Text('Выберите клиента',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: _bottomNav(),
          ),
          onWillPop: () => _onBackPressed(context),
        ));
  }

  BottomNavigationBar _bottomNav() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: 'режим таблиц',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_copy_outlined),
          label: 'удалить дубль.',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.vertical_align_top),
          label: 'переход',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.drive_file_rename_outline),
          label: 'подпись',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_email_outlined),
          label: 'отправить \n  на почту',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.print_outlined),
          label: 'печать',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: Colors.amber[800],
      onTap: skedController.onTapAction,
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: const Text('Закрыть окно?'),
                    content: const Text('Вы пытаетесь закрыть окно'),
                    actions: <Widget>[
                      ElevatedButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Да'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Нет'),
                      )
                    ]))) ??
        false;
  }
}
