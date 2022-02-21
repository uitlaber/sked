import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE skeds("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "operator_name TEXT NOT NULL,"
                "client TEXT NOT NULL,"
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                "work_type INTEGER NOT NULL"
                "data_type INTEGER NOT NULL"
                " );"
            "CREATE TABLE sked_rows("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "sort INTEGER NOT NULL,"
                "sked_id INTEGER NOT NULL,"
                "data TEXT DEFAULT NULL"
                ")"
        );
      },
      version: 1,
    );
  }
}