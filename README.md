# moor_db_viewer

[![pub package](https://img.shields.io/pub/v/moor_db_viewer.svg)](https://pub.dartlang.org/packages/moor_db_viewer)

This package allows us to view our database in our development app without the need of exporting your database file.
Filtering is done at database level

## Example

<img src="https://github.com/vanlooverenkoen/moor_db_viewer/blob/master/assets/example.gif?raw=true" alt="Example" width="300"/>

## Setup

### Add dependency to pubspec

[![pub package](https://img.shields.io/pub/v/moor_db_viewer.svg)](https://pub.dartlang.org/packages/moor_db_viewer)
```
dependencies:
  moor_db_viewer: <latest-version>
```

### Use it

Push a new route. The child will be the `MoorDbViewer` and pass your database to this screen.
```
final db = MyDatabase(); //This should be a singleton
Navigator.of(context).push(MaterialPageRoute(builder: (context) => MoorDbViewer(db)));
```

## Moor Config

### Using named columns

When using named columns you should add a @JsonKey to the column otherwise we won't be able to hide this table
```
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 6, max: 32)();

  @JsonKey('body') //This is required for the moor_db_viewer. 
  TextColumn get content => text().named('body')();

  IntColumn get category => integer().nullable()();
}
```

