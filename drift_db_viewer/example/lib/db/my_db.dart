import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'my_db.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 6, max: 32)();

  //This is required for the drift_db_viewer. otherwise we won't be able to hide this table
  @JsonKey('body')
  TextColumn get content => text().named('body')();

  IntColumn get category => integer().nullable()();

  DateTimeColumn get date => dateTime()();

  BoolColumn get completed => boolean()();

  RealColumn get realColumn => real()();

  BlobColumn get blobColumn => blob()();
}

@DataClassName("User")
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get firstName => text()();

  TextColumn get lastName => text()();

  IntColumn get age => integer()();

  TextColumn get zipcode => text()();

  TextColumn get city => text()();

  TextColumn get adress1 => text()();

  TextColumn get adress2 => text()();

  TextColumn get country => text()();

  TextColumn get phone => text()();

  TextColumn get email => text()();
}

class EmptyTable extends Table {
  IntColumn get todoA => integer()();
  IntColumn get todoB => integer()();

  @override
  Set<Column> get primaryKey => {todoA, todoB};

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY(todo_a) REFERENCES todos(id)',
        'FOREIGN KEY(todo_a) REFERENCES todos(id)',
      ];
}

LazyDatabase _openConnection() => LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'db.sqlite'));
      if (file.existsSync()) {
        file.deleteSync();
      }
      return NativeDatabase(file, logStatements: true);
    });

@DriftDatabase(tables: [
  Todos,
  EmptyTable,
  Users,
])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
