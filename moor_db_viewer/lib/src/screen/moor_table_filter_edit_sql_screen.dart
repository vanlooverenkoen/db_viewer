import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/navigator/db_navigator.dart';

class MoorTableFilterEditSqlScreen extends StatefulWidget {
  static const routeName = 'edit_sql';
  final String query;

  MoorTableFilterEditSqlScreen(this.query);

  @override
  _MoorTableFilterEditSqlScreenState createState() =>
      _MoorTableFilterEditSqlScreenState();
}

class _MoorTableFilterEditSqlScreenState
    extends State<MoorTableFilterEditSqlScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit SQL STATEMENT'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _onSaveClicked,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(ThemeDimens.padding16),
        children: [
          StyledTextField(
            controller: _controller,
            hint: 'Enter your custom sql query',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  void _onSaveClicked() =>
      DbViewerNavigator.of(context).goBack(result: _controller.text);
}
