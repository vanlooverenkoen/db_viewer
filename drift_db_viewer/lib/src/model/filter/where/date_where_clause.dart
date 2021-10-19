import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:db_viewer/src/model/filter/where/where_clause.dart';

class DateWhereClause extends WhereClause {
  DateWhereType _dateWhereType = DateWhereType.EQUALS;

  late DateTime _date;
  late TimeOfDay _time;

  @override
  String get typeName => 'DATE';

  String get dateString => '${_date.day}/${_date.month}/${_date.year}';

  String get timeString =>
      '${_time.hour.toString().padLeft(2, '0')} : ${_time.minute.toString().padLeft(2, '0')}';

  DateTime get date => _date;

  TimeOfDay get time => _time;

  DateWhereType get dateWhereType => _dateWhereType;

  DateWhereClause(String columnName) : super(columnName: columnName) {
    final now = DateTime.now();
    _date = DateTime(now.year, now.month, now.day);
    _time = TimeOfDay(hour: now.hour, minute: now.minute);
  }

  @override
  String getSqlWhereClause() {
    final sqlDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    final dateTimeParser = DateTimeType();
    final sqlValue = dateTimeParser.mapToSqlVariable(sqlDate);
    if (dateWhereType == DateWhereType.BEFORE) {
      return ' $columnName < $sqlValue';
    } else if (dateWhereType == DateWhereType.EQUALS) {
      return ' $columnName = $sqlValue';
    } else if (dateWhereType == DateWhereType.AFTER) {
      return ' $columnName > $sqlValue';
    }
    return '';
  }

  @override
  WhereClause copy() {
    final whereClause = DateWhereClause(columnName);
    whereClause._dateWhereType = _dateWhereType;
    whereClause._date = _date;
    whereClause._time = _time;
    return whereClause;
  }

  void onSelectedType(DateWhereType value) => _dateWhereType = value;

  void updateSelectedDate(DateTime newDate) => _date = newDate;

  void updateSelectedTime(TimeOfDay newTime) => _time = newTime;
}

enum DateWhereType {
  EQUALS,
  BEFORE,
  AFTER,
}
