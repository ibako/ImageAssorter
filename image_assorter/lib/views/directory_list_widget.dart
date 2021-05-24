import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:image_assorter/controllers/directory_list_controller.dart';
import 'package:image_assorter/helpers/async_widget_helper.dart';

class DirectoryListWidget extends StatefulWidget {
  @override
  _DirectoryListState createState() => _DirectoryListState();
}

class _DirectoryListState extends State<DirectoryListWidget> {
  final _controller = DirectoryListController();

  @override
  Widget build(BuildContext context) => createFutureBuilder(
      heavyWidgetGenerator: _buildTreeView(),
      updatingWidget: _buildUpdatingView);

  TreeViewTheme _buildTreeViewTheme() => TreeViewTheme(
      expanderTheme: ExpanderThemeData(
        type: ExpanderType.caret,
      ),
      iconTheme: IconThemeData(
        size: 32,
        color: Colors.blue,
      ));

  Future<Widget> _buildTreeView() async {
    await _controller.constructNodes();
    return Expanded(
        child: TreeView(
      theme: _buildTreeViewTheme(),
      controller: _controller.treeViewController,
      allowParentSelect: true,
    ));
  }

  Widget _buildUpdatingView() {
    return Container();
  }
}
