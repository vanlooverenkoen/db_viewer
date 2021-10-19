import 'package:drift_db_viewer_example/db/my_db.dart';

class DbUtil {
  static MyDatabase? _db;

  static MyDatabase get db {
    if (_db == null) {
      _db = MyDatabase();
    }
    return _db!;
  }
}
