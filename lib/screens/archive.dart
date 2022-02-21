import 'package:data_table_2/data_table_2.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sked/controllers/archive_controller.dart';
import 'package:intl/intl.dart';

class Archive extends StatelessWidget {
  Archive({Key? key}) : super(key: key);
  final controller = Get.find<ArchiveController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(title: const Text('Архив описей')),
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _filter(context),
              Row(
                children: [
                  Expanded(
                      child: (controller.skeds.isNotEmpty)
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                  showCheckboxColumn:
                                      controller.enableSelect.value,
                                  columnSpacing: 20,
                                  border: TableBorder.all(
                                    color: HexColor('#D4D4D4'),
                                  ),
                                  columns: const [
                                    DataColumn2(label: Text('#')),
                                    DataColumn2(label: Text('Клиент')),
                                    DataColumn2(label: Text('Дата и время')),
                                    DataColumn2(label: Text('Кол-во строк')),
                                    DataColumn2(label: Text('Оператор')),
                                    DataColumn2(
                                        label: Text('Отправлено на эл. почту')),
                                  ],
                                  rows: controller.skeds.map((item) {
                                    var index = controller.skeds.indexOf(item);
                                    index = controller.page.value + index;

                                    var dateTime = DateTime.parse(
                                        item.created_at.toString());
                                    var date = DateFormat("d-MM-yyyy HH:mm")
                                        .format(dateTime);
                                    return DataRow2(
                                        selected: controller.selected
                                            .contains(item.id),
                                        onLongPress: () => Get.toNamed(
                                            '/sked/' + item.id.toString()),
                                        onSelectChanged: (newValue) {
                                          if (newValue != null && newValue) {
                                            controller.selected.add(item.id);
                                          } else {
                                            controller.selected.remove(item.id);
                                          }
                                        },
                                        cells: <DataCell>[
                                          DataCell(Text(index.toString())),
                                          DataCell(Text(
                                              item.client_name.toString())),
                                          DataCell(Text(date)),
                                          const DataCell(Text("57")),
                                          DataCell(Text(
                                              item.operator_name.toString())),
                                          DataCell(Text(
                                              (item.is_sended ?? false)
                                                  ? "ДА"
                                                  : "Нет")),
                                        ]);
                                  }).toList()),
                            )
                          : Container(
                              padding: const EdgeInsets.all(20),
                              child: const Center(
                                child: Text('Нет данных'),
                              )))
                ],
              ),
            ],
          )),
          bottomNavigationBar: _bottomNav(),
        ));
  }

  BottomNavigationBar _bottomNav() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.upload),
          label: 'экспорт',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'настройка экспорта',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.check),
          label: (!controller.enableSelect.value)
              ? 'выделение'
              : 'отлючить выделение',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.delete),
          label: 'удаление',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.arrow_left),
          label: 'стр. назад',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.arrow_right),
          label: 'стр. назад',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: Colors.amber[800],
      onTap: controller.onTapAction,
    );
  }

  Widget _filter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.searchController,
              onChanged: (text) {
                controller.query.value = text;
                controller.loadSkeds();
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                label: Text('ПОИСК по имени клиента'),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          IconButton(
              onPressed: () async {
                DateTime selectedDate = DateTime.now();
                final DateTime? selected = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2025),
                );
                if (selected != selectedDate) {
                  controller.selectedDate.value = selected.toString();
                  controller.loadSkeds();
                }
              },
              icon: const Icon(Icons.calendar_month)),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () => controller.clearFilter(),
            child: const Text('Сброс поиска'),
          )
        ],
      ),
    );
  }
}
