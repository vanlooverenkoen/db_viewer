// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String title;
  final String content;
  final int? category;
  final DateTime date;
  final bool completed;
  final double realColumn;
  final Uint8List blobColumn;
  Todo(
      {required this.id,
      required this.title,
      required this.content,
      this.category,
      required this.date,
      required this.completed,
      required this.realColumn,
      required this.blobColumn});
  factory Todo.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Todo(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}body'])!,
      category: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      completed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}completed'])!,
      realColumn: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}real_column'])!,
      blobColumn: const BlobType()
          .mapFromDatabaseResponse(data['${effectivePrefix}blob_column'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(content);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int?>(category);
    }
    map['date'] = Variable<DateTime>(date);
    map['completed'] = Variable<bool>(completed);
    map['real_column'] = Variable<double>(realColumn);
    map['blob_column'] = Variable<Uint8List>(blobColumn);
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      date: Value(date),
      completed: Value(completed),
      realColumn: Value(realColumn),
      blobColumn: Value(blobColumn),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['body']),
      category: serializer.fromJson<int?>(json['category']),
      date: serializer.fromJson<DateTime>(json['date']),
      completed: serializer.fromJson<bool>(json['completed']),
      realColumn: serializer.fromJson<double>(json['realColumn']),
      blobColumn: serializer.fromJson<Uint8List>(json['blobColumn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(content),
      'category': serializer.toJson<int?>(category),
      'date': serializer.toJson<DateTime>(date),
      'completed': serializer.toJson<bool>(completed),
      'realColumn': serializer.toJson<double>(realColumn),
      'blobColumn': serializer.toJson<Uint8List>(blobColumn),
    };
  }

  Todo copyWith(
          {int? id,
          String? title,
          String? content,
          int? category,
          DateTime? date,
          bool? completed,
          double? realColumn,
          Uint8List? blobColumn}) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        category: category ?? this.category,
        date: date ?? this.date,
        completed: completed ?? this.completed,
        realColumn: realColumn ?? this.realColumn,
        blobColumn: blobColumn ?? this.blobColumn,
      );
  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('completed: $completed, ')
          ..write('realColumn: $realColumn, ')
          ..write('blobColumn: $blobColumn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, content, category, date, completed, realColumn, blobColumn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.category == this.category &&
          other.date == this.date &&
          other.completed == this.completed &&
          other.realColumn == this.realColumn &&
          other.blobColumn == this.blobColumn);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<int?> category;
  final Value<DateTime> date;
  final Value<bool> completed;
  final Value<double> realColumn;
  final Value<Uint8List> blobColumn;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.category = const Value.absent(),
    this.date = const Value.absent(),
    this.completed = const Value.absent(),
    this.realColumn = const Value.absent(),
    this.blobColumn = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    this.category = const Value.absent(),
    required DateTime date,
    required bool completed,
    required double realColumn,
    required Uint8List blobColumn,
  })  : title = Value(title),
        content = Value(content),
        date = Value(date),
        completed = Value(completed),
        realColumn = Value(realColumn),
        blobColumn = Value(blobColumn);
  static Insertable<Todo> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<int?>? category,
    Expression<DateTime>? date,
    Expression<bool>? completed,
    Expression<double>? realColumn,
    Expression<Uint8List>? blobColumn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'body': content,
      if (category != null) 'category': category,
      if (date != null) 'date': date,
      if (completed != null) 'completed': completed,
      if (realColumn != null) 'real_column': realColumn,
      if (blobColumn != null) 'blob_column': blobColumn,
    });
  }

  TodosCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? content,
      Value<int?>? category,
      Value<DateTime>? date,
      Value<bool>? completed,
      Value<double>? realColumn,
      Value<Uint8List>? blobColumn}) {
    return TodosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      date: date ?? this.date,
      completed: completed ?? this.completed,
      realColumn: realColumn ?? this.realColumn,
      blobColumn: blobColumn ?? this.blobColumn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['body'] = Variable<String>(content.value);
    }
    if (category.present) {
      map['category'] = Variable<int?>(category.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (realColumn.present) {
      map['real_column'] = Variable<double>(realColumn.value);
    }
    if (blobColumn.present) {
      map['blob_column'] = Variable<Uint8List>(blobColumn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('completed: $completed, ')
          ..write('realColumn: $realColumn, ')
          ..write('blobColumn: $blobColumn')
          ..write(')'))
        .toString();
  }
}

class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TodosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'body', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<int?> category = GeneratedColumn<int?>(
      'category', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool?> completed = GeneratedColumn<bool?>(
      'completed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (completed IN (0, 1))');
  final VerificationMeta _realColumnMeta = const VerificationMeta('realColumn');
  @override
  late final GeneratedColumn<double?> realColumn = GeneratedColumn<double?>(
      'real_column', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _blobColumnMeta = const VerificationMeta('blobColumn');
  @override
  late final GeneratedColumn<Uint8List?> blobColumn =
      GeneratedColumn<Uint8List?>('blob_column', aliasedName, false,
          type: const BlobType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, category, date, completed, realColumn, blobColumn];
  @override
  String get aliasedName => _alias ?? 'todos';
  @override
  String get actualTableName => 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['body']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    if (data.containsKey('real_column')) {
      context.handle(
          _realColumnMeta,
          realColumn.isAcceptableOrUnknown(
              data['real_column']!, _realColumnMeta));
    } else if (isInserting) {
      context.missing(_realColumnMeta);
    }
    if (data.containsKey('blob_column')) {
      context.handle(
          _blobColumnMeta,
          blobColumn.isAcceptableOrUnknown(
              data['blob_column']!, _blobColumnMeta));
    } else if (isInserting) {
      context.missing(_blobColumnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Todo.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(_db, alias);
  }
}

class EmptyTableData extends DataClass implements Insertable<EmptyTableData> {
  final int todoA;
  final int todoB;
  EmptyTableData({required this.todoA, required this.todoB});
  factory EmptyTableData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EmptyTableData(
      todoA: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}todo_a'])!,
      todoB: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}todo_b'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['todo_a'] = Variable<int>(todoA);
    map['todo_b'] = Variable<int>(todoB);
    return map;
  }

  EmptyTableCompanion toCompanion(bool nullToAbsent) {
    return EmptyTableCompanion(
      todoA: Value(todoA),
      todoB: Value(todoB),
    );
  }

  factory EmptyTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmptyTableData(
      todoA: serializer.fromJson<int>(json['todoA']),
      todoB: serializer.fromJson<int>(json['todoB']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'todoA': serializer.toJson<int>(todoA),
      'todoB': serializer.toJson<int>(todoB),
    };
  }

  EmptyTableData copyWith({int? todoA, int? todoB}) => EmptyTableData(
        todoA: todoA ?? this.todoA,
        todoB: todoB ?? this.todoB,
      );
  @override
  String toString() {
    return (StringBuffer('EmptyTableData(')
          ..write('todoA: $todoA, ')
          ..write('todoB: $todoB')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(todoA, todoB);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmptyTableData &&
          other.todoA == this.todoA &&
          other.todoB == this.todoB);
}

class EmptyTableCompanion extends UpdateCompanion<EmptyTableData> {
  final Value<int> todoA;
  final Value<int> todoB;
  const EmptyTableCompanion({
    this.todoA = const Value.absent(),
    this.todoB = const Value.absent(),
  });
  EmptyTableCompanion.insert({
    required int todoA,
    required int todoB,
  })  : todoA = Value(todoA),
        todoB = Value(todoB);
  static Insertable<EmptyTableData> custom({
    Expression<int>? todoA,
    Expression<int>? todoB,
  }) {
    return RawValuesInsertable({
      if (todoA != null) 'todo_a': todoA,
      if (todoB != null) 'todo_b': todoB,
    });
  }

  EmptyTableCompanion copyWith({Value<int>? todoA, Value<int>? todoB}) {
    return EmptyTableCompanion(
      todoA: todoA ?? this.todoA,
      todoB: todoB ?? this.todoB,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (todoA.present) {
      map['todo_a'] = Variable<int>(todoA.value);
    }
    if (todoB.present) {
      map['todo_b'] = Variable<int>(todoB.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmptyTableCompanion(')
          ..write('todoA: $todoA, ')
          ..write('todoB: $todoB')
          ..write(')'))
        .toString();
  }
}

class $EmptyTableTable extends EmptyTable
    with TableInfo<$EmptyTableTable, EmptyTableData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EmptyTableTable(this._db, [this._alias]);
  final VerificationMeta _todoAMeta = const VerificationMeta('todoA');
  @override
  late final GeneratedColumn<int?> todoA = GeneratedColumn<int?>(
      'todo_a', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _todoBMeta = const VerificationMeta('todoB');
  @override
  late final GeneratedColumn<int?> todoB = GeneratedColumn<int?>(
      'todo_b', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [todoA, todoB];
  @override
  String get aliasedName => _alias ?? 'empty_table';
  @override
  String get actualTableName => 'empty_table';
  @override
  VerificationContext validateIntegrity(Insertable<EmptyTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('todo_a')) {
      context.handle(
          _todoAMeta, todoA.isAcceptableOrUnknown(data['todo_a']!, _todoAMeta));
    } else if (isInserting) {
      context.missing(_todoAMeta);
    }
    if (data.containsKey('todo_b')) {
      context.handle(
          _todoBMeta, todoB.isAcceptableOrUnknown(data['todo_b']!, _todoBMeta));
    } else if (isInserting) {
      context.missing(_todoBMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {todoA, todoB};
  @override
  EmptyTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EmptyTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EmptyTableTable createAlias(String alias) {
    return $EmptyTableTable(_db, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String firstName;
  final String lastName;
  final int age;
  final String zipcode;
  final String city;
  final String adress1;
  final String adress2;
  final String country;
  final String phone;
  final String email;
  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.age,
      required this.zipcode,
      required this.city,
      required this.adress1,
      required this.adress2,
      required this.country,
      required this.phone,
      required this.email});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      firstName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name'])!,
      lastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name'])!,
      age: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}age'])!,
      zipcode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}zipcode'])!,
      city: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}city'])!,
      adress1: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}adress1'])!,
      adress2: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}adress2'])!,
      country: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}country'])!,
      phone: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['age'] = Variable<int>(age);
    map['zipcode'] = Variable<String>(zipcode);
    map['city'] = Variable<String>(city);
    map['adress1'] = Variable<String>(adress1);
    map['adress2'] = Variable<String>(adress2);
    map['country'] = Variable<String>(country);
    map['phone'] = Variable<String>(phone);
    map['email'] = Variable<String>(email);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      age: Value(age),
      zipcode: Value(zipcode),
      city: Value(city),
      adress1: Value(adress1),
      adress2: Value(adress2),
      country: Value(country),
      phone: Value(phone),
      email: Value(email),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      age: serializer.fromJson<int>(json['age']),
      zipcode: serializer.fromJson<String>(json['zipcode']),
      city: serializer.fromJson<String>(json['city']),
      adress1: serializer.fromJson<String>(json['adress1']),
      adress2: serializer.fromJson<String>(json['adress2']),
      country: serializer.fromJson<String>(json['country']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'age': serializer.toJson<int>(age),
      'zipcode': serializer.toJson<String>(zipcode),
      'city': serializer.toJson<String>(city),
      'adress1': serializer.toJson<String>(adress1),
      'adress2': serializer.toJson<String>(adress2),
      'country': serializer.toJson<String>(country),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String>(email),
    };
  }

  User copyWith(
          {int? id,
          String? firstName,
          String? lastName,
          int? age,
          String? zipcode,
          String? city,
          String? adress1,
          String? adress2,
          String? country,
          String? phone,
          String? email}) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age,
        zipcode: zipcode ?? this.zipcode,
        city: city ?? this.city,
        adress1: adress1 ?? this.adress1,
        adress2: adress2 ?? this.adress2,
        country: country ?? this.country,
        phone: phone ?? this.phone,
        email: email ?? this.email,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('age: $age, ')
          ..write('zipcode: $zipcode, ')
          ..write('city: $city, ')
          ..write('adress1: $adress1, ')
          ..write('adress2: $adress2, ')
          ..write('country: $country, ')
          ..write('phone: $phone, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, age, zipcode, city,
      adress1, adress2, country, phone, email);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.age == this.age &&
          other.zipcode == this.zipcode &&
          other.city == this.city &&
          other.adress1 == this.adress1 &&
          other.adress2 == this.adress2 &&
          other.country == this.country &&
          other.phone == this.phone &&
          other.email == this.email);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<int> age;
  final Value<String> zipcode;
  final Value<String> city;
  final Value<String> adress1;
  final Value<String> adress2;
  final Value<String> country;
  final Value<String> phone;
  final Value<String> email;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.age = const Value.absent(),
    this.zipcode = const Value.absent(),
    this.city = const Value.absent(),
    this.adress1 = const Value.absent(),
    this.adress2 = const Value.absent(),
    this.country = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required int age,
    required String zipcode,
    required String city,
    required String adress1,
    required String adress2,
    required String country,
    required String phone,
    required String email,
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        age = Value(age),
        zipcode = Value(zipcode),
        city = Value(city),
        adress1 = Value(adress1),
        adress2 = Value(adress2),
        country = Value(country),
        phone = Value(phone),
        email = Value(email);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<int>? age,
    Expression<String>? zipcode,
    Expression<String>? city,
    Expression<String>? adress1,
    Expression<String>? adress2,
    Expression<String>? country,
    Expression<String>? phone,
    Expression<String>? email,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (age != null) 'age': age,
      if (zipcode != null) 'zipcode': zipcode,
      if (city != null) 'city': city,
      if (adress1 != null) 'adress1': adress1,
      if (adress2 != null) 'adress2': adress2,
      if (country != null) 'country': country,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<int>? age,
      Value<String>? zipcode,
      Value<String>? city,
      Value<String>? adress1,
      Value<String>? adress2,
      Value<String>? country,
      Value<String>? phone,
      Value<String>? email}) {
    return UsersCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      zipcode: zipcode ?? this.zipcode,
      city: city ?? this.city,
      adress1: adress1 ?? this.adress1,
      adress2: adress2 ?? this.adress2,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (zipcode.present) {
      map['zipcode'] = Variable<String>(zipcode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (adress1.present) {
      map['adress1'] = Variable<String>(adress1.value);
    }
    if (adress2.present) {
      map['adress2'] = Variable<String>(adress2.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('age: $age, ')
          ..write('zipcode: $zipcode, ')
          ..write('city: $city, ')
          ..write('adress1: $adress1, ')
          ..write('adress2: $adress2, ')
          ..write('country: $country, ')
          ..write('phone: $phone, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String?> firstName = GeneratedColumn<String?>(
      'first_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String?> lastName = GeneratedColumn<String?>(
      'last_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int?> age = GeneratedColumn<int?>(
      'age', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _zipcodeMeta = const VerificationMeta('zipcode');
  @override
  late final GeneratedColumn<String?> zipcode = GeneratedColumn<String?>(
      'zipcode', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String?> city = GeneratedColumn<String?>(
      'city', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _adress1Meta = const VerificationMeta('adress1');
  @override
  late final GeneratedColumn<String?> adress1 = GeneratedColumn<String?>(
      'adress1', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _adress2Meta = const VerificationMeta('adress2');
  @override
  late final GeneratedColumn<String?> adress2 = GeneratedColumn<String?>(
      'adress2', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _countryMeta = const VerificationMeta('country');
  @override
  late final GeneratedColumn<String?> country = GeneratedColumn<String?>(
      'country', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String?> phone = GeneratedColumn<String?>(
      'phone', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        firstName,
        lastName,
        age,
        zipcode,
        city,
        adress1,
        adress2,
        country,
        phone,
        email
      ];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('zipcode')) {
      context.handle(_zipcodeMeta,
          zipcode.isAcceptableOrUnknown(data['zipcode']!, _zipcodeMeta));
    } else if (isInserting) {
      context.missing(_zipcodeMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('adress1')) {
      context.handle(_adress1Meta,
          adress1.isAcceptableOrUnknown(data['adress1']!, _adress1Meta));
    } else if (isInserting) {
      context.missing(_adress1Meta);
    }
    if (data.containsKey('adress2')) {
      context.handle(_adress2Meta,
          adress2.isAcceptableOrUnknown(data['adress2']!, _adress2Meta));
    } else if (isInserting) {
      context.missing(_adress2Meta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodosTable todos = $TodosTable(this);
  late final $EmptyTableTable emptyTable = $EmptyTableTable(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [todos, emptyTable, users];
}
