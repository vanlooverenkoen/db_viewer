import 'package:db_viewer/src/style/theme_dimens.dart';
import 'package:db_viewer/src/viewmodel/table_item_detail_viewer_viewmodel.dart';
import 'package:db_viewer/src/widget/provider/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;

class TableItemDetailScreen extends StatefulWidget {
  static const routeName = 'table-item-detail';

  final ItemDetailArgument arguments;

  const TableItemDetailScreen(
    this.arguments, {
    Key? key,
  }) : super(key: key);

  @override
  _TableItemDetailScreenState createState() => _TableItemDetailScreenState();
}

class _TableItemDetailScreenState extends State<TableItemDetailScreen>
    implements TableItemDetailViewerNavigator {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ProviderWidget<TableItemDetailViewerViewModel>(
      consumer: (context, viewModel, child) => Scaffold(
        key: _key,
        appBar: AppBar(
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
              padding: const EdgeInsets.all(ThemeDimens.padding16),
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
                      const SizedBox(height: ThemeDimens.padding16),
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
          TableItemDetailViewerViewModel()..init(this, widget.arguments),
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
  String tableName;
  Map<String, dynamic> data;

  ItemDetailArgument(this.tableName, this.data);
}
