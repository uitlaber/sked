import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sked/models/model.dart';

class ArchiveController extends GetxController {
  List selectedClient = [].obs;
  var skeds = <Sked>[].obs;
  RxString selectedDate = ''.obs;
  var query = ''.obs;
  TextEditingController searchController = TextEditingController();
  RxInt page = 1.obs;
  RxInt perPage = 20.obs;
  RxInt total = 0.obs;
  RxBool enableSelect = false.obs;
  RxList selected = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadSkeds();
  }

  /// Загрузка списка описей
  loadSkeds() async {
    final result = await MyAppDatabaseModel()
        .execDataTable('SELECT COUNT(*) as totalRows FROM skeds');

    total.value = int.parse(result[0]['totalRows'].toString());

    String whereSql = '';

    if (query.value.isNotEmpty) {
      whereSql = 'client_name LIKE "%${query.value.trim()}%" ';
    }

    if (selectedDate.isNotEmpty) {
      var date = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(selectedDate.value))
          .toString();

      String start =
          DateTime.parse('$date 00:00:00').millisecondsSinceEpoch.toString();
      String end =
          DateTime.parse('$date 23:59:59').millisecondsSinceEpoch.toString();

      whereSql = whereSql +
          (whereSql.isNotEmpty ? ' AND ' : '') +
          'created_at BETWEEN  $start AND $end';
    }

    skeds.value = await Sked()
        .select()
        .where(whereSql)
        .page(page.value, perPage.value)
        .toList();

    if (skeds.value.isEmpty && query.value.isEmpty && selectedDate.isEmpty) {
      page.value--;
      loadSkeds();
    }

    if (kDebugMode) {
      print(whereSql);
      print("-------SKEDS_LENG " + skeds.length.toString());
    }
  }

  void onTapAction(int index) {
    if (index == 2) {
      enableSelect.value = !enableSelect.value;
    }

    if (index == 3) {
      for (var skedId in selected.value) {
        print('$skedId deleted');
        deleteSked(skedId);
      }
      loadSkeds();
    }

    if (index == 4 && page > 1) {
      page.value--;
      loadSkeds();
    }
    if (index == 5) {
      page.value++;
      loadSkeds();
    }

    if (kDebugMode) {
      print(index);
    }
  }

  void deleteSked(int id) async {
    print('deleted $id');
    await Sked().select().id.equals(id).delete();
  }

  /// Очистка фильтра поиска
  void clearFilter() {
    selectedDate.value = '';
    query.value = '';
    searchController.text = '';
    loadSkeds();
  }
}
