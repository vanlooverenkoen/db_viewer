import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/screen/moor_db_viewer_widget.dart';
import 'package:moor_db_viewer/style/theme_dimens.dart';
import 'package:moordbviewerexample/db/db_util.dart';
import 'package:moordbviewerexample/db/my_db.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyDatabase get db => DbUtil.db;
  var _dbViewerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Home Screen'),
          ),
          body: Stack(
            children: [
              ListView(
                children: [
                  MaterialButton(
                    child: Text('GO to dbviewer'),
                    onPressed: _onGoToDbViewerClicked,
                  ),
                  MaterialButton(
                    child: Text('Add Category'),
                    onPressed: _addCategory,
                  ),
                  MaterialButton(
                    child: Text('Remove first Category'),
                    onPressed: _removeCategory,
                  ),
                  MaterialButton(
                    child: Text('Add TODO'),
                    onPressed: _addTodo,
                  ),
                  MaterialButton(
                    child: Text('Remove first TODO'),
                    onPressed: _removeTodo,
                  ),
                  MaterialButton(
                    child: Text('Add 100 TODO'),
                    onPressed: _add100Todos,
                  ),
                  MaterialButton(
                    child: Text('Add 10000 TODO'),
                    onPressed: _add10000Todos,
                  ),
                  MaterialButton(
                    child: Text('Add 1000000 TODO'),
                    onPressed: _add1000000Todos,
                  ),
                  MaterialButton(
                    child: Text('clear db'),
                    onPressed: _clearDb,
                  ),
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: _dbViewerOpen,
          child: MoorDbViewer(db),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            child: Icon(Icons.developer_mode),
            onPressed: _onFabClicked,
          ),
        ),
      ],
    );
  }

  void _onGoToDbViewerClicked() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MoorDbViewer(db)));
  }

  Future<void> _removeTodo() async {
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    final result = await db.select(db.todos).get();
    if (result.isEmpty) return;
    final first = result.first;
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    await (db.delete(db.todos)..where((item) => item.id.equals(first.id))).go();
  }

  Future<void> _removeCategory() async {
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    final result = await db.select(db.categories).get();
    if (result.isEmpty) return;
    final first = result.first;
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    await (db.delete(db.categories)..where((item) => item.id.equals(first.id))).go();
  }

  Future<void> _addCategory() async {
    await addCategory();
  }

  void _onFabClicked() {
    setState(() {
      _dbViewerOpen = !_dbViewerOpen;
    });
  }

  Future<void> _add100Todos() async {
    for (var i = 0; i < 100; i++) {
      await _addTodo();
    }
  }

  Future<void> _add10000Todos() async {
    print('STARTED');
    for (var i = 0; i < 10000; i++) {
      await _addTodo();
    }
    print('SAVED');
  }

  Future<void> _add1000000Todos() async {
    print('STARTED');
    for (var i = 0; i < 1000000; i++) {
      await _addTodo();
    }
    print('SAVED');
  }

  Future<void> _addTodo() async {
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    await db.into(db.todos).insert(TodosCompanion.insert(title: 'TODO: ${DateTime.now().microsecondsSinceEpoch.toString()}', content: 'COntent'));
  }

  Future<void> addCategory() async {
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    await db.into(db.categories).insert(CategoriesCompanion.insert(description: 'Category: ${DateTime.now().microsecondsSinceEpoch.toString()}'));
  }

  Future<void> _clearDb() async {
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    await db.delete(db.todos).go();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    await db.delete(db.categories).go();
  }
}
