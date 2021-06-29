import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:moor/moor.dart';
import 'package:moor/moor.dart' as moor;
import 'package:moor_db_viewer/src/style/theme_colors.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/style/theme_text_styles.dart';
import 'package:moor_db_viewer/src/viewmodel/moor_table_item_detail_viewer_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/provider/provider_widget.dart';

class MoorTableItemDetailScreen extends StatefulWidget {
  static const routeName = 'moor-table-item-detail';

  final ItemDetailArgument arguments;

  MoorTableItemDetailScreen(this.arguments);

  @override
  _MoorTableItemDetailScreenState createState() =>
      _MoorTableItemDetailScreenState();
}

class _MoorTableItemDetailScreenState extends State<MoorTableItemDetailScreen>
    implements MoorTableItemDetailViewerNavigator {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ProviderWidget<MoorTableItemDetailViewerViewModel>(
      consumer: (context, viewModel, child) => Scaffold(
        key: _key,
        appBar: AppBar(
          brightness: Theme.of(context).primaryColorBrightness,
          centerTitle: Theme.of(context).platform == TargetPlatform.iOS,
          title: Text(viewModel.title),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (viewModel.error != null)
              return Center(child: Text(viewModel.error!));
            if (!viewModel.hasData && viewModel.hasFilter)
              return Center(
                  child: Text(
                      'No data found for your current filter on the `${viewModel.tableName}` table'));
            if (!viewModel.hasData)
              return Center(
                  child: Text(
                      'No data added to the `${viewModel.tableName}` table'));
            return ListView.builder(
              padding: EdgeInsets.all(ThemeDimens.padding16),
              itemCount: viewModel.amountOfColumns,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: ThemeDimens.padding8),
                  child: flutter.Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.getKey(index),
                        style: theme.textTheme.headline6,
                      ),
                      Text(
                        viewModel.getValue(index),
                        style: theme.textTheme.bodyText1,
                      ),
                      Container(height: ThemeDimens.padding16),
                      Container(
                        height: 1,
                        color: theme.dividerColor,
                        width: double.infinity,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      create: () =>
          MoorTableItemDetailViewerViewModel()..init(this, widget.arguments),
    );
  }

  @override
  void showToast(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );

    final scaffoldContext = _key.currentContext;
    if (scaffoldContext != null) {
      ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
    }
  }
}

class ItemDetailArgument {
  TableInfo<moor.Table, dynamic> table;
  Map<String, dynamic> data;

  ItemDetailArgument(this.table, this.data);
}
