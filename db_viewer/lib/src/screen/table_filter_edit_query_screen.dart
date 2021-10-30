import 'package:db_viewer/src/navigator/db_navigator.dart';
import 'package:db_viewer/src/style/theme_dimens.dart';
import 'package:db_viewer/src/widget/general/styled/styled_text_field.dart';
import 'package:flutter/material.dart';

class TableFilterEditQueryScreen extends StatefulWidget {
  static const routeName = 'edit-query';
  final String query;

  TableFilterEditQueryScreen(this.query);

  @override
  _TableFilterEditQueryScreenState createState() =>
      _TableFilterEditQueryScreenState();
}

class _TableFilterEditQueryScreenState
    extends State<TableFilterEditQueryScreen> {
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
        title: const Text('Edit Query'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _onSaveClicked,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(ThemeDimens.padding16),
        children: [
          StyledTextField(
            controller: _controller,
            hint: 'Enter your custom query',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  void _onSaveClicked() =>
      DbViewerNavigator.of(context).goBack(result: _controller.text);
}
